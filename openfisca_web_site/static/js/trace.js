'use strict';

var $ = window.$,
  _ = window._,
  // Rainbow = window.Rainbow,
  React = window.React;

var cx = React.addons.classSet,
  PureRenderMixin = React.addons.PureRenderMixin,
  update = React.addons.update;


// Helpers, model and services functions.

function buildVariableId(variableName, variablePeriod) {
  var toValidBootstrapId = function(str) {
    return str.replace(':', '-');
  };
  return variablePeriod ? variableName + '-' + toValidBootstrapId(variablePeriod) : variableName;
}


function calculate(apiUrl, simulationJson, onSuccess, onError) {
  var calculateUrl = apiUrl + 'api/1/calculate';
  $.ajax(calculateUrl, {
    contentType: 'application/json',
    data: JSON.stringify(simulationJson),
    dataType: 'json',
    type: 'POST',
    xhrFields: {
      withCredentials: true
    }
  })
  .done(function (data/*, textStatus, jqXHR*/) {
    onSuccess(data);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    onError(
      errorThrown && jqXHR.responseText ?
        errorThrown + ': ' + jqXHR.responseText :
        errorThrown || jqXHR.responseText || 'unknown'
    );
  });
}


function fetchField(apiUrl, name, baseReforms, onSuccess, onError) {
  var fieldUrl = apiUrl + 'api/1/field';
  $.ajax(fieldUrl, {
    data: {
      reform: baseReforms,
      variable: name,
    },
    dataType: 'json',
    traditional: true,
    type: 'GET',
    xhrFields: {
      withCredentials: true,
    },
  })
  .done(function(data/*, textStatus, jqXHR*/) {
    onSuccess(data);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    onError(
      errorThrown && jqXHR.responseText ?
        errorThrown + ': ' + jqXHR.responseText :
        errorThrown || jqXHR.responseText || 'unknown'
    );
  });
}


function findConsumerTracebacks(tracebacks, name, period) {
  // Find formula tracebacks which call the given variable at the given period.
  var filteredTracebacks = _.filter(tracebacks, function(traceback) {
    if (traceback.input_variables && traceback.input_variables.length) {
      var inputVariable = _.find(traceback.input_variables, function(inputVariableData) {
        var argumentName = inputVariableData[0],
          argumentPeriod = inputVariableData[1];

        return argumentName === name && (
          period === null || argumentPeriod === null || argumentPeriod === period
        );
      });
      return inputVariable;
    } else {
      return false;
    }
  });
  return filteredTracebacks.length ? filteredTracebacks : null;
}


function findTraceback(tracebacks, name, period) {
  // Find variable traceback at the given name and period.
  // Assumes that a traceback exists only once for a given name and period, in the tracebacks list.
  return _.find(tracebacks, function(traceback) {
    return traceback.name === name && (traceback.period === null || traceback.period === period);
  });
}


function findTracebacks(tracebacks, name, period) {  // jshint ignore:line
  // Find variable traceback at the given name and period.
  // Assumes that a traceback exists only once for a given name and period, in the tracebacks list.
  return _.filter(tracebacks, function(traceback) {
    return traceback.name === name && (period === null || traceback.period === null || traceback.period === period);
  });
}


function getEntityBackgroundColor(entity) {
  return {
    fam: 'success',
    familles: 'success',
    foy: 'info',
    foyers_fiscaux: 'info',
    ind: 'primary',
    individus: 'primary',
    men: 'warning',
    menages: 'warning',
  }[entity] || entity;
}


function getEntityKeyPlural(entity) {
  return {
    fam: 'familles',
    foy: 'foyers fiscaux',
    ind: 'individus',
    men: 'ménages',
  }[entity] || entity;
}


function getQueryParameters(str) {
  return (str || document.location.search).replace(/(^\?)/,'').split("&")
    .map(function(n){return n = n.split("="),this[n[0]] = n[1],this;}.bind({}))[0];
}


var guid = (function() {
  function s4() {
    return Math.floor((1 + Math.random()) * 0x10000)
               .toString(16)
               .substring(1);
  }
  return function() {
    return s4() + s4() + '-' + s4() + '-' + s4() + '-' +
           s4() + '-' + s4() + s4() + s4();
  };
})();


function normalizePeriod(period) {
  var dashMatches = period.match(/-/g);
  if (dashMatches) {
    var dashesCount = dashMatches.length;
    var monthPrefix = 'month:';
    if (dashesCount === 1 && startsWith(period, monthPrefix)) {
      return period.slice(monthPrefix.length);
    }
  }
  return period;
}


function startsWith(str, startStr) {
  return str.indexOf(startStr) === 0;
}


// Components

var AutoSizedTextArea = React.createClass({
  mixins: [PureRenderMixin],
  propTypes: {
    disabled: React.PropTypes.bool,
    onChange: React.PropTypes.func,
    value: React.PropTypes.string,
  },
  render: function() {
    return (
      <textarea
        className="form-control"
        disabled={this.props.disabled}
        onChange={this.props.onChange}
        rows={this.props.value.split('\n').length + 1}
        style={{marginBottom: '1em'}}
        value={this.props.value}></textarea>
    );
  },
});


var TraceTool = React.createClass({
  mixins: [PureRenderMixin],
  propTypes: {
    apiDocUrl: React.PropTypes.string.isRequired,
    apiUrl: React.PropTypes.string.isRequired,
    defaultSimulationText: React.PropTypes.string,
  },
  calculate: function() {
    var onError = function(errorMessage) {
      this.setState({
        extrapolatedConsumerTracebacksByVariableId: null,
        simulationError: errorMessage,
        simulationInProgress: false,
        tracebacks: null,
        variableByName: null,
      });
      window.tracebacks = null; // DEBUG
    }.bind(this);
    var onSuccess = function(data) {
      var firstScenarioTracebacks = data.tracebacks['0'],
        firstSimulationVariables = data.variables['0'];
      window.tracebacks = firstScenarioTracebacks; // DEBUG
      this.setState({
        extrapolatedConsumerTracebacksByVariableId: this.findExtrapolatedConsumerTracebacksByVariableId(
          firstScenarioTracebacks
        ),
        simulationError: null,
        simulationInProgress: false,
        tracebacks: firstScenarioTracebacks,
        variableByName: firstSimulationVariables,
      });
    }.bind(this);
    this.setState({simulationInProgress: true}, function() {
      calculate(this.props.apiUrl, this.state.simulationJson, onSuccess, onError);
    });
  },
  componentDidMount: function() {
    this.calculate();
  },
  fetchField: function(variableName, baseReforms) {
    var onError = function(errorMessage) {
      var variableHolderChangeset = {};
      variableHolderChangeset[variableName] = null;
      var newVariableHolderByName = update(this.state.variableHolderByName, {$merge: variableHolderChangeset});
      var variableHolderErrorChangeset = {};
      variableHolderErrorChangeset[variableName] = errorMessage;
      var newVariableHolderErrorByName = update(
        this.state.variableHolderErrorByName,
        {$merge: variableHolderErrorChangeset}
      );
      this.setState({
        variableHolderByName: newVariableHolderByName,
        variableHolderErrorByName: newVariableHolderErrorByName,
      });
    }.bind(this);
    var onSuccess = function(data) {
      var variableHolderChangeset = {};
      variableHolderChangeset[variableName] = data.value;
      var newVariableHolderByName = update(this.state.variableHolderByName, {$merge: variableHolderChangeset});
      var variableHolderErrorChangeset = {};
      variableHolderErrorChangeset[variableName] = null;
      var newVariableHolderErrorByName = update(
        this.state.variableHolderErrorByName,
        {$merge: variableHolderErrorChangeset}
      );
      this.setState({
        variableHolderByName: newVariableHolderByName,
        variableHolderErrorByName: newVariableHolderErrorByName,
      });
    }.bind(this);
    fetchField(this.props.apiUrl, variableName, baseReforms, onSuccess, onError);
  },
  findExtrapolatedConsumerTracebacksByVariableId: function(tracebacks) {
    var extrapolatedConsumerTracebacksByVariableId = {};
    tracebacks.forEach(function(traceback) {
      if (traceback.used_periods) {
        var extrapolatedConsumerTracebacks = tracebacks.filter(function(traceback1) {
          return traceback.name === traceback1.name && traceback1.used_periods &&
            _.contains(traceback1.used_periods, traceback.period);
        });
        var variableId = buildVariableId(traceback.name, traceback.period);
        extrapolatedConsumerTracebacksByVariableId[variableId] = extrapolatedConsumerTracebacks;
      }
    });
    return extrapolatedConsumerTracebacksByVariableId;
  },
  getInitialState: function() {
    return {
      showDefaultFormulas: false,
      simulationError: null,
      simulationInProgress: false,
      simulationJson: this.getSimulationJson(this.props.defaultSimulationText),
      simulationText: this.props.defaultSimulationText,
      toggleStatusByVariableId: {},
      tracebacks: null,
      variableByName: null,
      variableHolderByName: {},
      variableHolderErrorByName: {},
    };
  },
  getSimulationJson: function(simulationText) {
    var simulationJson;
    try {
        simulationJson = JSON.parse(simulationText);
    } catch (error) {
        this.setState({simulationError: 'JSON parse error: ' + error.message});
        return;
    }
    simulationJson.trace = true;
    return simulationJson;
  },
  handleShowDefaultFormulasChange: function(event) {
    this.setState({showDefaultFormulas: event.target.checked});
  },
  handleSimulationFormSubmit: function(event) {
    event.preventDefault();
    this.setState({simulationJson: this.getSimulationJson(this.state.simulationText)}, function() {
      this.calculate();
    });
  },
  handleSimulationTextChange: function(event) {
    this.setState({
      simulationError: null,
      simulationText: event.target.value,
      tracebacks: null,
      variableByName: null,
      variableHolderByName: {},
      variableHolderErrorByName: {},
    }, function() {
      // Fetch holders for previously opened variables.
      _.map(this.state.toggleStatusByVariableId, function(variableInfos) {
        if ( ! (variableInfos.name in this.state.variableHolderByName)) {
          this.handleVariablePanelOpen(variableInfos.name, variableInfos.period);
        }
      }.bind(this));
    });
  },
  handleVariablePanelOpen: function(variableName, variablePeriod) {
    this.handleVariablePanelToggle(variableName, variablePeriod, true);
  },
  handleVariablePanelToggle: function(variableName, variablePeriod, forceValue) {
    var variableId = buildVariableId(variableName, variablePeriod);
    var toggleStatusByVariableIdChangeset = {};
    toggleStatusByVariableIdChangeset[variableId] = {
      isOpened: _.isUndefined(forceValue) ? ! this.state.toggleStatusByVariableId[variableId] : forceValue,
      name: variableName,
      period: variablePeriod,
    };
    var newToggleStatusByVariableId = update(
      this.state.toggleStatusByVariableId,
      {$merge: toggleStatusByVariableIdChangeset}
    );
    this.setState({toggleStatusByVariableId: newToggleStatusByVariableId});
    if (newToggleStatusByVariableId && ! (variableName in this.state.variableHolderByName)) {
      this.fetchField(variableName, this.state.simulationJson.base_reforms);
    }
  },
  render: function() {
    return (
      <div>
        {this.renderSimulationForm()}
        {
          this.state.simulationError ? (
            <div className="alert alert-danger">
              <p>
                <strong>Erreur à l'appel de l'API calculate !</strong>
              </p>
              <pre style={{background: 'transparent', border: 0}}>{this.state.simulationError}</pre>
            </div>
          ) : (
            this.state.simulationInProgress ? (
              <div className="alert alert-info">
                <p>Simulation en cours...</p>
              </div>
            ) : (
              this.state.tracebacks && (
                <div>
                  {this.renderVariablesPanels()}
                  <p>{this.state.tracebacks.length + ' formules et variables au total'}</p>
                </div>
              )
            )
          )
        }
      </div>
    );
  },
  renderSimulationForm: function() {
    var permaLinkParameters = getQueryParameters();
    permaLinkParameters.simulation = this.state.simulationJson;
    var permaLinkHref = '?' + $.param(permaLinkParameters);
    return (
      <form className="form" role="form" onSubmit={this.handleSimulationFormSubmit}>
        <div className="panel panel-default">
          <div className="panel-heading" role="tab" id="collapseSimulationTextHeading">
            <h4 className="panel-title">
              <a
                aria-controls="collapseSimulationText"
                aria-expanded="true"
                data-toggle="collapse"
                href="#collapseSimulationText">
                Appel de la simulation
              </a>
            </h4>
          </div>
          <div
            aria-expanded="true"
            aria-labelledby="collapseSimulationTextHeading"
            className="panel-collapse collapse"
            id="collapseSimulationText"
            role="tabpanel">
            <div className="panel-body">
              <p>
                {'URL de l\'API de simulation : ' + this.props.apiUrl + 'api/1/calculate '}
                (<a href={this.props.apiDocUrl + '#calculate'} rel="external" target="_blank">documentation</a>)
              </p>
              <p>Paramètre l'URL <code>api_url</code> (exemple : http://www.openfisca.fr/outils/trace?api_url=http://localhost:2000/)</p>
              <AutoSizedTextArea
                disabled={this.state.simulationInProgress}
                onChange={this.handleSimulationTextChange}
                value={this.state.simulationText}
              />
              <button className="btn btn-primary" type="submit">Simuler</button>
              <a href={permaLinkHref} rel="external" style={{marginLeft: '1em'}} target="_blank">Lien permanent</a>
            </div>
          </div>
        </div>
        <div className="checkbox">
          <label>
            <input
              onChange={this.handleShowDefaultFormulasChange}
              checked={this.props.showDefaultFormulas}
              type="checkbox"
            />
            Afficher aussi les formules appelées avec toutes les valeurs par défaut
          </label>
        </div>
      </form>
    );
  },
  renderVariablesPanels: function() {
    var scenario = this.state.simulationJson.scenarios[0];
    var scenarioPeriod = normalizePeriod(scenario.period || scenario.year.toString()),
      simulationVariables = this.state.simulationJson.variables;
    return (
      this.state.tracebacks.map(function(traceback, idx) {
        if (idx < this.state.tracebacks.length - 1 && traceback.default_input_variables && ! this.state.showDefaultFormulas) {
          return null;
        }
        var variable = this.state.variableByName[traceback.name];
        var variableId = buildVariableId(traceback.name, traceback.period);
        var values = _.isArray(variable) ? variable : variable[traceback.period];
        var toggleStatus = this.state.toggleStatusByVariableId[variableId];
        var isOpened = toggleStatus && toggleStatus.isOpened;
        return (
          <VariablePanel
            cellType={traceback.cell_type}
            computedConsumerTracebacks={
              isOpened ? findConsumerTracebacks(this.state.tracebacks, traceback.name, traceback.period) : null
            }
            default={traceback.default}
            entity={traceback.entity}
            extrapolatedConsumerTracebacks={
              this.state.extrapolatedConsumerTracebacksByVariableId &&
                this.state.extrapolatedConsumerTracebacksByVariableId[variableId]
            }
            hasAllDefaultArguments={traceback.default_input_variables}
            holder={this.state.variableHolderByName[traceback.name]}
            holderError={this.state.variableHolderErrorByName[traceback.name]}
            isComputed={traceback.is_computed}
            inputVariables={
              traceback.input_variables && traceback.input_variables.length ? traceback.input_variables : null
            }
            isOpened={isOpened}
            key={idx}
            label={traceback.label}
            name={traceback.name}
            onOpen={this.handleVariablePanelOpen}
            onToggle={this.handleVariablePanelToggle}
            period={traceback.period === null ? null : normalizePeriod(traceback.period)}
            scenarioPeriod={scenarioPeriod}
            showDefaultFormulas={this.state.showDefaultFormulas}
            simulationVariables={simulationVariables}
            tracebacks={this.state.tracebacks}
            usedPeriods={traceback.used_periods}
            values={values}
            variableByName={this.state.variableByName}
          />
        );
      }.bind(this))
    );
  },
});


var Value = React.createClass({
  mixins: [PureRenderMixin],
  propTypes: {
    isDefaultArgument: React.PropTypes.bool,
    type: React.PropTypes.string,
    value: React.PropTypes.any.isRequired,
  },
  format: function() {
    if (this.props.value === '') {
      return '""';
    } else {
      var formattedValue = this.props.value.toLocaleString('fr');
      if (this.props.type === 'monetary') {
        formattedValue += ' €';
      }
      return formattedValue;
    }
  },
  render: function() {
    var formattedValue = this.format();
    return (
      <span className={cx({'bg-danger': this.props.isDefaultArgument})}>{formattedValue}</span>
    );
  },
});


var VariableLink = React.createClass({
  mixins: [PureRenderMixin],
  propTypes: {
    children: React.PropTypes.string.isRequired,
    name: React.PropTypes.string.isRequired,
    onOpen: React.PropTypes.func.isRequired,
    period: React.PropTypes.string,
  },
  handleClick: function(event) {
    event.preventDefault();
    this.props.onOpen(this.props.name, this.props.period);
    var $link = $(event.target.hash);
    if ($link.length) {
      location.hash = event.target.hash;
      $(document.body).scrollTop($link.offset().top);
    } else {
      console.error('This link has no target: ' + event.target.hash);
    }
  },
  render: function() {
    var variableId = buildVariableId(this.props.name, this.props.period);
    return (
      <a href={'#' + variableId} onClick={this.handleClick}>{this.props.children}</a>
    );
  },
});


var VariablePanel = React.createClass({
  mixins: [PureRenderMixin],
  propTypes: {
    cellType: React.PropTypes.string,
    computedConsumerTracebacks: React.PropTypes.array,
    default: React.PropTypes.any,
    entity: React.PropTypes.string.isRequired,
    extrapolatedConsumerTracebacks: React.PropTypes.array,
    hasAllDefaultArguments: React.PropTypes.bool,
    holder: React.PropTypes.object,
    holderError: React.PropTypes.string,
    isComputed: React.PropTypes.bool,
    inputVariables: React.PropTypes.array,
    isOpened: React.PropTypes.bool,
    label: React.PropTypes.string.isRequired,
    name: React.PropTypes.string.isRequired,
    onToggle: React.PropTypes.func.isRequired,
    period: React.PropTypes.string,
    scenarioPeriod: React.PropTypes.string.isRequired,
    showDefaultFormulas: React.PropTypes.bool,
    simulationVariables: React.PropTypes.arrayOf(React.PropTypes.string).isRequired,
    tracebacks: React.PropTypes.array.isRequired,
    usedPeriods: React.PropTypes.array,
    values: React.PropTypes.array.isRequired,
    variableByName: React.PropTypes.object.isRequired,
  },
  // colorize: function() {
  //   if (this.props.isOpened && this.props.holder) {
  //     Rainbow.color();
  //   }
  // },
  // componentDidMount: function() {
  //   // this.colorize();
  // },
  // componentDidUpdate: function() {
  //   // this.colorize();
  // },
  handlePanelHeadingClick: function() {
    this.props.onToggle(this.props.name, this.props.period);
  },
  render: function() {
    return (
      <div
        className={cx('panel', this.props.hasAllDefaultArguments ? 'panel-warning' : 'panel-default')}
        id={buildVariableId(this.props.name, this.props.period)}>
        {this.renderPanelHeading()}
        {
          this.props.isOpened && (
            <div className="panel-body" style={{position: 'relative'}}>
              {
                this.props.holderError ? (
                  <div className="alert alert-danger">
                    <p>
                      <strong>Erreur !</strong>
                    </p>
                    <pre style={{background: 'transparent', border: 0}}>{this.props.holderError}</pre>
                  </div>
                ) : (
                  this.props.holder ? this.renderPanelBodyContent() : (
                    <p>Chargement en cours...</p>
                  )
                )
              }
              <div style={{position: 'absolute', right: 7, top: 5}}>
                <a
                  href={window.legislationExplorerUrl + 'variables/' + this.props.name}
                  rel="external"
                  target="_blank"
                  title="Ouvrir dans l'explorateur de variables, hors du cadre de cette simulation">
                  Page de la variable
                </a>
              </div>
            </div>
          )
        }
      </div>
    );
  },
  renderComputedConsumers: function() {
    return (
      <div>
        <h3>Formules appelantes</h3>
        <ul className="computed-consumers">
          {
            this.props.computedConsumerTracebacks.map(function(computedConsumerTraceback, idx) {
              var isVariableDisplayed = ! computedConsumerTraceback.default_input_variables || this.props.showDefaultFormulas;
              return (
                <li key={idx}>
                  {
                    isVariableDisplayed ? (
                      <VariableLink
                        name={computedConsumerTraceback.name}
                        onOpen={this.props.onOpen}
                        period={computedConsumerTraceback.period}>
                        {computedConsumerTraceback.name + ' / ' + computedConsumerTraceback.period}
                      </VariableLink>
                    ) : (
                      computedConsumerTraceback.name + ' / ' + computedConsumerTraceback.period
                    )
                  }
                  <span> : {computedConsumerTraceback.label}</span>
                </li>
              );
            }.bind(this))
          }
        </ul>
      </div>
    );
  },
  renderExtrapolatedConsumers: function() {
    return (
      <div>
        <h3>Formules appelantes extrapolées</h3>
        <ul className="extrapolated-consumers">
          {
            this.props.extrapolatedConsumerTracebacks.map(function(extrapolatedConsumerTraceback, idx) {
              var isVariableDisplayed = ! extrapolatedConsumerTraceback.default_input_variables ||
                this.props.showDefaultFormulas;
              return (
                <li key={idx}>
                  {
                    isVariableDisplayed ? (
                      <VariableLink
                        name={extrapolatedConsumerTraceback.name}
                        onOpen={this.props.onOpen}
                        period={extrapolatedConsumerTraceback.period}>
                        {extrapolatedConsumerTraceback.name + ' / ' + extrapolatedConsumerTraceback.period}
                      </VariableLink>
                    ) : (
                      extrapolatedConsumerTraceback.name + ' / ' + extrapolatedConsumerTraceback.period
                    )
                  }
                  <span> : {extrapolatedConsumerTraceback.label}</span>
                </li>
              );
            }.bind(this))
          }
        </ul>
      </div>
    );
  },
  renderFormula: function(formula) {
    var variableId = buildVariableId(this.props.name, this.props.period),
      accordionId = 'accordion-' + variableId;
    if (formula['@type'] === 'DatedFormula') {
      return (
        <div>
          <h3>DatedFormula <small>Fonctions datées</small></h3>
          <p>Une ou plusieurs des formules ci-dessous sont appelées en fonction de la période demandée.</p>
          {formula.doc && formula.doc != this.props.label && <p>{formula.doc}</p>}
          <div className="panel-group" id={accordionId} role="tablist" aria-multiselectable="true">
            {
              formula.dated_formulas.map(function(datedFormula, idx) {
                var mainVariableId = accordionId + '-' + idx;
                var headingId = mainVariableId + '-heading';
                return (
                  <div className="panel panel-default" key={idx}>
                    <div className="panel-heading" role="tab" id={headingId}>
                      <h4 className="panel-title">
                        <a
                          aria-controls={mainVariableId}
                          aria-expanded="false"
                          data-parent={'#' + accordionId}
                          data-toggle="collapse"
                          href={'#' + mainVariableId}>
                          {datedFormula.start_instant + ' – ' + datedFormula.stop_instant}
                        </a>
                      </h4>
                    </div>
                    <div
                      aria-labelledby={headingId}
                      className={cx({collapse: true, 'panel-collapse ': true})}
                      id={mainVariableId}
                      role="tabpanel">
                      <div className="panel-body">
                        {this.renderFormula(datedFormula.formula)}
                      </div>
                    </div>
                  </div>
                );
              }.bind(this))
            }
          </div>
        </div>
      );
    } else if (formula['@type'] === 'SimpleFormula') {
      var githubUrl = 'https://github.com/openfisca/openfisca-france/tree/master/' +
        formula.module.split('.').join('/') + '.py#L' + formula.line_number + '-' +
        (formula.line_number + formula.source.trim().split('\n').length - 1);
      var sourceCodeId = guid();
      return (
        <div>
          {formula.doc && formula.doc != this.props.label && <p>{formula.doc}</p>}
          <div>
            <h3>Formules appelées</h3>
            <table className="table">
              <thead>
                <tr>
                  <th>Nom</th>
                  <th>Période</th>
                  <th>Libellé</th>
                  <th>Entité</th>
                  {this.props.inputVariables && <th className="text-right">Valeur</th>}
                </tr>
              </thead>
              <tbody>
                {
                  this.props.inputVariables && this.props.inputVariables.map(function(inputVariableData, idx) {
                    var argumentName = inputVariableData[0],
                      argumentPeriod = inputVariableData[1];
                    var isComputed = argumentName in this.props.variableByName; // Useful with some dated formulas.
                    var argumentValues = isComputed ? (
                      _.isArray(this.props.variableByName[argumentName]) ?
                        this.props.variableByName[argumentName] :
                        this.props.variableByName[argumentName][argumentPeriod]
                    ) : null;
                    // TODO index tracebacks before
                    var argumentTraceback = findTraceback(this.props.tracebacks, argumentName, argumentPeriod);
                    var isVariableDisplayed = ! argumentTraceback || ! argumentTraceback.default_input_variables ||
                      this.props.showDefaultFormulas;
                    return argumentTraceback && (
                      <tr key={idx}>
                        <td>
                          {
                            isVariableDisplayed ? (
                              <VariableLink name={argumentName} onOpen={this.props.onOpen} period={argumentPeriod}>
                                {argumentName}
                              </VariableLink>
                            ) : argumentName
                          }
                        </td>
                        <td>{argumentPeriod || '–'}</td>
                        <td>{argumentTraceback.label !== argumentName ? argumentTraceback.label : ''}</td>
                        <td>
                          <span className={
                            cx('label', 'label-' + getEntityBackgroundColor(argumentTraceback.entity))
                          }>
                            {argumentTraceback.entity}
                          </span>
                        </td>
                        <td>
                          {
                            argumentValues && (
                              <ul className="list-unstyled">
                                {
                                  argumentValues.map(function(value, idx) {
                                    var isDefaultArgument = this.props.hasAllDefaultArguments ||
                                      this.props.argumentTracebackByName &&
                                      this.props.argumentTracebackByName[argumentName].default === value;
                                    var valueType = this.props.argumentTracebackByName &&
                                      this.props.argumentTracebackByName[argumentName] ?
                                      this.props.argumentTracebackByName[argumentName].cell_type :
                                      null;
                                    return (
                                      <li className="text-right" key={idx}>
                                        <samp>
                                          <Value
                                            isDefaultArgument={isDefaultArgument}
                                            type={valueType}
                                            value={value}
                                          />
                                        </samp>
                                      </li>
                                    );
                                  }.bind(this))
                                }
                              </ul>
                            )
                          }
                        </td>
                      </tr>
                    );
                  }.bind(this))
                }
              </tbody>
            </table>
          </div>
          <h3>
            <a
              aria-controls={sourceCodeId}
              aria-expanded='false'
              data-target={'#' + sourceCodeId}
              data-toggle="collapse"
              href='#'
              onClick={function(event) { event.preventDefault(); }}
              title='afficher / masquer'>
              Code source
            </a>
            <span> – <a href={githubUrl} rel="external" target="_blank">ouvrir dans GitHub</a></span>
          </h3>
          <pre className='collapse' id={sourceCodeId}>
            <code data-language="python">{formula.source}</code>
          </pre>
        </div>
      );
    }
  },
  renderPanelBodyContent: function() {
    return (
      <div>
        {
          _.contains(this.props.simulationVariables, this.props.name) &&
          this.props.period === this.props.scenarioPeriod && (
            <p><span className='label label-default'>Appel simulation</span></p>
          )
        }
        {
          this.props.usedPeriods ? (
            this.renderUsedPeriods()
          ) : (
            <div>
              {
                (this.props.hasAllDefaultArguments || ! this.props.isComputed) && (
                  <div>
                    {
                      this.props.hasAllDefaultArguments && (
                        <span className='label label-default'>Valeurs par défaut</span>
                      )
                    }
                    {
                      ! this.props.isComputed && (
                        <span className='label label-default'>Variable d'entrée</span>
                      )
                    }
                  </div>
                )
              }
              {
                this.props.holder.formula && ! this.props.usedPeriods &&
                  this.renderFormula(this.props.holder.formula)
              }
            </div>
          )
        }
        {this.props.computedConsumerTracebacks && this.renderComputedConsumers()}
        {this.props.extrapolatedConsumerTracebacks && this.renderExtrapolatedConsumers()}
      </div>
    );
  },
  renderPanelHeading: function() {
    return (
      <div className="panel-heading" onClick={this.handlePanelHeadingClick} style={{cursor: 'pointer'}}>
        <div className="row">
          <div className="col-sm-3">
            <span className={cx('glyphicon', this.props.isOpened ? 'glyphicon-minus' : 'glyphicon-plus')}></span>
            <code>{this.props.name}</code>
          </div>
          <div className="col-sm-1">
            <small>{this.props.period || '–'}</small>
          </div>
          <div className="col-sm-5">
            {this.props.label}
          </div>
          <div className="col-sm-1">
            <span className={cx('label', 'label-' + getEntityBackgroundColor(this.props.entity))}>
              {getEntityKeyPlural(this.props.entity)}
            </span>
          </div>
          <div className="col-sm-2">
            <ul className="list-unstyled">
              {
                this.props.values.map(function(value, idx) {
                  return (
                    <li className="text-right" key={idx}>
                      <samp>
                        <Value
                          isDefaultArgument={value === this.props.default}
                          type={this.props.cellType}
                          value={value}
                        />
                      </samp>
                    </li>
                  );
                }.bind(this))
              }
            </ul>
          </div>
        </div>
      </div>
    );
  },
  renderUsedPeriods: function() {
    var displayTransformationColumn = _.isNumber(this.props.values[0]);
    return (
      <div>
        <h3>Valeurs extrapolées depuis</h3>
        <table className="table">
          <thead>
            <tr>
              <th>Nom</th>
              <th>Période</th>
              <th className="text-right">Valeur</th>
              {displayTransformationColumn && <th>Transformation</th>}
            </tr>
          </thead>
          <tbody>
            {
              this.props.usedPeriods.map(function(period, idx) {
                var values = this.props.variableByName[this.props.name][period];
                var usedPeriodTraceback = findTraceback(this.props.tracebacks, this.props.name, period);
                var isVariableDisplayed = ! usedPeriodTraceback.default_input_variables ||
                  this.props.showDefaultFormulas;
                return (
                  <tr key={idx}>
                    <td>
                      {
                        isVariableDisplayed ? (
                          <VariableLink name={this.props.name} onOpen={this.props.onOpen} period={period}>
                            {this.props.name}
                          </VariableLink>
                        ) : this.props.name
                      }
                    </td>
                    <td>
                      {period}
                    </td>
                    <td>
                      <ul className="list-unstyled">
                        {
                          values.map(function(value, idx) {
                            return (
                              <li className="text-right" key={idx}>
                                <samp>
                                  <Value
                                    isDefaultArgument={value === this.props.default}
                                    type={this.props.cellType}
                                    value={value}
                                  />
                                </samp>
                              </li>
                            );
                          }.bind(this))
                        }
                      </ul>
                    </td>
                    {
                      displayTransformationColumn && (
                        <td>
                          <ul className="list-unstyled">
                            {
                              values.map(function(value, idx) {
                                return (
                                  <li key={idx}>
                                    <samp>
                                      {
                                        value === this.props.values[idx] ? (
                                          '='
                                        ) : (
                                          value > this.props.values[idx] ?
                                            '/ ' + (value / this.props.values[idx]).toLocaleString('fr') :
                                            '× ' + (this.props.values[idx] / value).toLocaleString('fr')
                                        )
                                      }
                                    </samp>
                                  </li>
                                );
                              }.bind(this))
                            }
                          </ul>
                        </td>
                      )
                    }
                  </tr>
                );
              }.bind(this))
            }
          </tbody>
        </table>
      </div>
    );
  },
});



var mountNode = document.getElementById('trace-container');
var traceTool = (
  <TraceTool
    apiDocUrl={window.apiDocUrl}
    apiUrl={window.apiUrl}
    defaultSimulationText={window.defaultSimulationText}
  />
);
React.render(traceTool, mountNode);
window.traceTool = traceTool;
