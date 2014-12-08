'use strict';

var $ = window.$,
  _ = window._,
  // Rainbow = window.Rainbow,
  React = window.React;

var cx = React.addons.classSet,
  PureRenderMixin = React.addons.PureRenderMixin,
  update = React.addons.update;


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


function fetchField(apiUrl, name, onSuccess, onError) {
  var fieldUrl = apiUrl + 'api/1/field';
  $.ajax(fieldUrl, {
    data: {
      variable: name,
    },
    dataType: 'json',
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
    if (traceback.arguments) {
      var argumentPeriod = traceback.arguments[name];
      return period === null || argumentPeriod === null || argumentPeriod === period;
    } else {
      return false;
    }
  });
  return filteredTracebacks.length ? filteredTracebacks : null;
}


function findTracebacks(tracebacks, name, period) {
  // Find variable traceback at the given name and period.
  // Assumes that a traceback exists only one for a given name and period, in the tracebacks list.
  var filteredTracebacks = _.filter(tracebacks, function(traceback) {
    return traceback.name === name && (period === null || traceback.period === null || traceback.period === period);
  });
  return filteredTracebacks.length ? filteredTracebacks : null;
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
  propTypes: {
    apiDocUrl: React.PropTypes.string.isRequired,
    apiUrl: React.PropTypes.string.isRequired,
    defaultSimulationText: React.PropTypes.string,
  },
  calculate: function() {
    var simulationJson;
    try {
        simulationJson = JSON.parse(this.state.simulationText);
    } catch (error) {
        this.setState({simulationError: 'JSON parse error: ' + error.message});
        return;
    }
    simulationJson.trace = true;
    var onError = function(errorMessage) {
      this.setState({
        variableByName: null,
        simulationError: errorMessage,
        simulationInProgress: false,
        tracebacks: null,
      });
    }.bind(this);
    var onSuccess = function(data) {
      var firstScenarioTracebacks = data.tracebacks['0'],
        firstSimulationVariables = data.variables['0'];
      this.computedConsumerTracebacksByVariableId = {};
      this.setState({
        simulationError: null,
        simulationInProgress: false,
        tracebacks: firstScenarioTracebacks,
        variableByName: firstSimulationVariables,
      });
      window.tracebacks = firstScenarioTracebacks; // DEBUG
    }.bind(this);
    this.setState({simulationInProgress: true}, function() {
      calculate(this.props.apiUrl, simulationJson, onSuccess, onError);
    });
  },
  componentDidMount: function() {
    this.calculate();
  },
  fetchField: function(variableName) {
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
    fetchField(this.props.apiUrl, variableName, onSuccess, onError);
  },
  getInitialState: function() {
    return {
      showDefaultFormulas: false,
      simulationError: null,
      simulationInProgress: false,
      simulationText: this.props.defaultSimulationText,
      toggleStatusByVariableId: {},
      tracebacks: null,
      variableByName: null,
      variableHolderByName: {},
      variableHolderErrorByName: {},
    };
  },
  handleShowDefaultFormulasChange: function(event) {
    this.setState({showDefaultFormulas: event.target.checked});
  },
  handleSimulationFormSubmit: function(event) {
    event.preventDefault();
    this.calculate();
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
    var newToggleStatusByVariableId = update(this.state.toggleStatusByVariableId, {$merge: toggleStatusByVariableIdChangeset});
    this.setState({toggleStatusByVariableId: newToggleStatusByVariableId});
    if (newToggleStatusByVariableId && ! (variableName in this.state.variableHolderByName)) {
      this.fetchField(variableName);
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
                </div>
              )
            )
          )
        }
      </div>
    );
  },
  renderSimulationForm: function() {
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
              <AutoSizedTextArea
                disabled={this.state.simulationInProgress}
                onChange={this.handleSimulationTextChange}
                value={this.state.simulationText}
              />
              <button className="btn btn-primary" type="submit">Simuler</button>
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
    var simulationJson = JSON.parse(this.state.simulationText),
      scenarioPeriod = simulationJson.scenarios[0].period,
      simulationVariables = simulationJson.variables;
    return (
      this.state.tracebacks.map(function(traceback) {
        if (traceback.default_arguments && ! this.state.showDefaultFormulas) {
          return null;
        }
        var variable = this.state.variableByName[traceback.name];
        var variableId = buildVariableId(traceback.name, traceback.period);
        var values = _.isArray(variable) ? variable : variable[traceback.period];
        var toggleStatus = this.state.toggleStatusByVariableId[variableId];
        var isOpened = toggleStatus && toggleStatus.isOpened;
        var argumentTracebackByName = _(traceback.arguments).map(function(argumentPeriod, argumentName) {
          if (argumentPeriod === null) {
            throw new Error('traceback argument has no period for name ' + argumentName);
          }
          var argumentTraceback = _.first(findTracebacks(this.state.tracebacks, argumentName, argumentPeriod));
          return [argumentName, argumentTraceback];
        }.bind(this)).object().valueOf();
        return (
          <VariablePanel
            argumentPeriodByName={traceback.arguments}
            argumentTracebackByName={argumentTracebackByName}
            cellType={traceback.cell_type}
            computedConsumerTracebacks={isOpened ? findConsumerTracebacks(traceback.name, traceback.period) : null}
            default={traceback.default}
            entity={traceback.entity}
            hasAllDefaultArguments={traceback.default_arguments}
            holder={this.state.variableHolderByName[traceback.name]}
            holderError={this.state.variableHolderErrorByName[traceback.name]}
            isComputed={traceback.isComputed}
            isOpened={isOpened}
            key={variableId}
            label={traceback.label}
            name={traceback.name}
            onOpen={this.handleVariablePanelOpen}
            onToggle={this.handleVariablePanelToggle}
            period={traceback.period}
            scenarioPeriod={scenarioPeriod}
            simulationVariables={simulationVariables}
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
      <span className={cx({'bg-danger': ! this.props.isDefaultArgument})}>{formattedValue}</span>
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
    argumentPeriodByName: React.PropTypes.object,
    argumentTracebackByName: React.PropTypes.object,
    cellType: React.PropTypes.string,
    computedConsumerTracebacks: React.PropTypes.array,
    default: React.PropTypes.any,
    entity: React.PropTypes.string.isRequired,
    hasAllDefaultArguments: React.PropTypes.bool,
    holder: React.PropTypes.object,
    holderError: React.PropTypes.string,
    isComputed: React.PropTypes.bool,
    isOpened: React.PropTypes.bool,
    label: React.PropTypes.string.isRequired,
    name: React.PropTypes.string.isRequired,
    onToggle: React.PropTypes.func.isRequired,
    period: React.PropTypes.string,
    scenarioPeriod: React.PropTypes.string.isRequired,
    simulationVariables: React.PropTypes.arrayOf(React.PropTypes.string).isRequired,
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
                  this.props.holder ? this.renderBody() : (
                    <p>Chargement en cours...</p>
                  )
                )
              }
              <div style={{position: 'absolute', right: 7, top: 5}}>
                <a
                  href={window.variablesExplorerUrl + '/' + this.props.name}
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
  renderBody: function() {
    return (
      <div>
        {
          this.props.hasAllDefaultArguments && (
            <small>Tous les arguments de cette formule ont des valeurs par défaut.</small>
          )
        }
        {
          this.props.isComputed && (
            <p><span className='label label-default'>Variable d'entrée</span></p>
          )
        }
        {
          _.contains(this.props.simulationVariables, this.props.name) &&
          this.props.period === this.props.scenarioPeriod && (
            <small>Cette formule à cette période est demandée directement par l'appel de la simulation.</small>
          )
        }
        {
          this.props.holder.formula && ! this.props.usedPeriods &&
            this.renderFormula(this.props.holder.formula)
        }
        {
          this.props.usedPeriods && (
            <div>
              <h3>Formules appelées</h3>
              <p>Valeurs extrapolées à partir de :</p>
              <table className="table">
                <thead>
                  <tr>
                    <th>Nom</th>
                    <th>Période</th>
                    <th className="text-right">Valeur</th>
                  </tr>
                </thead>
                <tbody>
                  {
                    this.props.usedPeriods.map(function(period, idx) {
                      var values = this.props.variableByName[this.props.name][period];
                      return (
                        <tr key={idx}>
                          <td>
                            <VariableLink name={this.props.name} onOpen={this.props.onOpen} period={period}>
                              {this.props.name}
                            </VariableLink>
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
                        </tr>
                      );
                    }.bind(this))
                  }
                </tbody>
              </table>
            </div>
          )
        }
        <h3>Formules appelantes</h3>
        {
          this.props.computedConsumerTracebacks ? (
            <div>
              <p>Formules qui appellent cette formule dans le cadre de cette simulation :</p>
              <ul className="consumers">
                {
                  this.props.computedConsumerTracebacks.map(function(computedConsumerTraceback, idx) {
                    return (
                      <li key={idx}>
                        <VariableLink
                          name={computedConsumerTraceback.name}
                          onOpen={this.props.onOpen}
                          period={computedConsumerTraceback.period}>
                          {computedConsumerTraceback.name + ' / ' + computedConsumerTraceback.period}
                        </VariableLink>
                        <span> : {computedConsumerTraceback.label}</span>
                      </li>
                    );
                  }.bind(this))
                }
              </ul>
            </div>
          ) : (
            <p>Cette formule n'est appelée par aucune autre formule.</p>
          )
        }
      </div>
    );
  },
  renderFormula: function(formula) {
    var variableId = buildVariableId(this.props.name, this.props.period),
      accordionId = 'accordion-' + variableId;
    var isCalled = function(formula) {
      return this.props.argumentPeriodByName &&
        formula.variables[0].name in this.props.argumentPeriodByName; // This is tricky.
    }.bind(this);
    if (formula['@type'] === 'AlternativeFormula') {
      return (
        <div>
          <h3>AlternativeFormula <small>Choix de fonctions</small></h3>
          {
            formula.doc && (
              <div>
                <h3>Description</h3>
                <pre>{formula.doc}</pre>
              </div>
            )
          }
          <div className="panel-group" id={accordionId} role="tablist" aria-multiselectable="true">
            {
              formula.alternative_formulas.map(function(formula, idx) {
                var mainVariableId = accordionId + '-' + idx;
                var headingId = mainVariableId + '-heading';
                var isFormulaCalled = isCalled(formula);
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
                          {(idx + 1).toString() + (isFormulaCalled ? '' : ' (non appelée)')}
                        </a>
                      </h4>
                    </div>
                    <div
                      aria-labelledby={headingId}
                      className={cx({collapse: true, in: isFormulaCalled, 'panel-collapse ': true})}
                      id={mainVariableId}
                      role="tabpanel">
                      <div className="panel-body">
                        {this.renderFormula(formula)}
                      </div>
                    </div>
                  </div>
                );
              }.bind(this))
            }
          </div>
        </div>
      );
    } else if (formula['@type'] === 'DatedFormula') {
      return (
        <div>
          <h3>DatedFormula <small>Fonctions datées</small></h3>
          <p>Une ou plusieurs des formules ci-dessous sont appelées en fonction de la période demandée.</p>
          {
            formula.doc && (
              <div>
                <h3>Description</h3>
                <pre>{formula.doc}</pre>
              </div>
            )
          }
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
    } else if (formula['@type'] === 'SelectFormula') {
      return (
        <div>
          <h3>SelectFormula <small>Choix de fonctions</small></h3>
          {
            formula.doc && (
              <div>
                <h3>Description</h3>
                <pre>{formula.doc}</pre>
              </div>
            )
          }
          <div className="panel-group" id={accordionId} role="tablist" aria-multiselectable="true">
            {
              _(formula.formula_by_main_variable).map(function(formula, mainVariable) {
                var mainVariableId = accordionId + '-' + mainVariable;
                var headingId = mainVariableId + '-heading';
                var isFormulaCalled = isCalled(formula);
                return (
                  <div className="panel panel-default" key={mainVariable}>
                    <div className="panel-heading" role="tab" id={headingId}>
                      <h4 className="panel-title">
                        <a
                          aria-controls={mainVariableId}
                          aria-expanded="false"
                          data-parent={'#' + accordionId}
                          data-toggle="collapse"
                          href={'#' + mainVariableId}>
                          {mainVariable + (isFormulaCalled ? '' : ' (non appelée)')}
                        </a>
                      </h4>
                    </div>
                    <div
                      aria-labelledby={headingId}
                      className={cx({collapse: true, in: isFormulaCalled, 'panel-collapse ': true})}
                      id={mainVariableId}
                      role="tabpanel">
                      <div className="panel-body">
                        {this.renderFormula(formula)}
                      </div>
                    </div>
                  </div>
                );
              }.bind(this)).valueOf()
            }
          </div>
        </div>
      );
    } else if (formula['@type'] === 'SimpleFormula') {
      var githubUrl = 'https://github.com/openfisca/openfisca-france/tree/master/' +
        formula.module.split('.').join('/') + '.py#L' + formula.line_number + '-' +
        (formula.line_number + formula.source.trim().split('\n').length - 1);
      var sourceCodeId = guid();
      var isFormulaCalled = isCalled(formula);
      return (
        <div>
          {
            formula.doc && (
              <div>
                <h3>Description</h3>
                <pre>{formula.doc}</pre>
              </div>
            )
          }
          <h3>Formules appelées</h3>
          <p>Formules appellées par cette formule dans le cadre de cette simulation :</p>
          <table className="table">
            <thead>
              <tr>
                <th>Nom</th>
                <th>Période</th>
                <th>Libellé</th>
                <th>Entité</th>
                {isFormulaCalled && <th className="text-right">Valeur</th>}
              </tr>
            </thead>
            <tbody>
              {
                formula.variables.map(function(variable, idx) {
                  var isPeriodAgnostic = this.props.argumentTracebackByName &&
                    variable.name in this.props.argumentTracebackByName &&
                    this.props.argumentTracebackByName[variable.name].period === null;
                  var argumentPeriod = isPeriodAgnostic ? null : (
                    this.props.argumentPeriodByName && this.props.argumentPeriodByName[variable.name]
                  );
                  // Useful with some [alternative, dated, selected] formulas.
                  var isComputed = variable.name in this.props.variableByName;
                  var argumentValues = isComputed ? (
                    _.isArray(this.props.variableByName[variable.name]) ?
                      this.props.variableByName[variable.name] :
                      this.props.variableByName[variable.name][argumentPeriod]
                  ) : null;
                  return (
                    <tr key={idx}>
                      <td>
                        {
                          isFormulaCalled ? (
                            <VariableLink name={variable.name} onOpen={this.props.onOpen} period={argumentPeriod}>
                              {variable.name}
                            </VariableLink>
                          ) : variable.name
                        }
                      </td>
                      <td>{argumentPeriod || '–'}</td>
                      <td>{variable.label !== variable.name ? variable.label : ''}</td>
                      <td>
                        <span className={cx('label', 'label-' + getEntityBackgroundColor(variable.entity))}>
                          {variable.entity}
                        </span>
                      </td>
                      {
                        isFormulaCalled && (
                          <td>
                            {
                              argumentValues && (
                                <ul className="list-unstyled">
                                  {
                                    argumentValues.map(function(value, idx) {
                                      var isDefaultArgument = this.props.hasAllDefaultArguments ||
                                        this.props.argumentTracebackByName &&
                                        this.props.argumentTracebackByName[variable.name].default === value;
                                      var valueType = this.props.argumentTracebackByName &&
                                        this.props.argumentTracebackByName[variable.name] ?
                                        this.props.argumentTracebackByName[variable.name].cell_type :
                                        null;
                                      return (
                                        <li className="text-right" key={idx}>
                                          <samp>
                                            <Value isDefaultArgument={isDefaultArgument} type={valueType} value={value} />
                                          </samp>
                                        </li>
                                      );
                                    }.bind(this))
                                  }
                                </ul>
                              )
                            }
                          </td>
                        )
                      }
                    </tr>
                  );
                }.bind(this))
              }
            </tbody>
          </table>
          <h3>
            <span>Code source – </span>
            <a
              aria-controls={sourceCodeId}
              aria-expanded='false'
              data-target={'#' + sourceCodeId}
              data-toggle="collapse"
              href='#'
              onClick={function(event) { event.preventDefault(); }}>
              afficher/masquer
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
