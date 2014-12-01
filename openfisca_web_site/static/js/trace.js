'use strict';

var $ = window.$,
  _ = window._,
  Rainbow = window.Rainbow,
  React = window.React;

var cx = React.addons.classSet,
  PureRenderMixin = React.addons.PureRenderMixin,
  update = React.addons.update;


function buildVariableId(variableName, variablePeriod) {
  return variablePeriod ? variableName + '-' + variablePeriod : variableName;
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


function fetchFields(apiUrl, onSuccess, onError) {
  var fieldUrls = apiUrl + 'api/1/fields';
  $.ajax(fieldUrls, {
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


function formatValue(value, valType) {
  if (value === '') {
    return '""';
  } else {
    var formattedValue = value.toLocaleString('fr');
    if (valType === 'monetary') {
      formattedValue += ' €';
    }
    return formattedValue;
  }
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
        firstScenarioVariables = data.variables['0'];
      this.computedConsumerTracebacksByVariableId = {};
      this.setState({
        simulationError: null,
        simulationInProgress: false,
        simulationText: this.props.defaultSimulationText,
        tracebacks: firstScenarioTracebacks,
        variableByName: firstScenarioVariables,
      });
      window.tracebacks = firstScenarioTracebacks; // DEBUG
    }.bind(this);
    this.setState({simulationInProgress: true}, function() {
      calculate(this.props.apiUrl, simulationJson, onSuccess, onError);
    });
  },
  componentDidMount: function() {
    this.calculate();
    this.fetchFields();
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
  fetchFields: function() {
    var onError = function(errorMessage) {
      this.setState({
        columns: null,
        prestations: null,
        fieldsError: errorMessage,
      });
    }.bind(this);
    var onSuccess = function(data) {
      this.setState({
        columns: data.columns,
        prestations: data.prestations,
        fieldsError: null,
      });
    }.bind(this);
    fetchFields(this.props.apiUrl, onSuccess, onError);
  },
  findComputedConsumerTracebacks: function(variableName, variablePeriod) {
    // Find formulas which call the given formula and period.
    var variableId = variableName + '-' + variablePeriod;
    if ( ! (variableId in this.computedConsumerTracebacksByVariableId)) {
      var computedConsumerTracebacks = [];
      for (var tracebackIdx in this.state.tracebacks) {
        var traceback = this.state.tracebacks[tracebackIdx];
        for (var argumentName in traceback.arguments) {
          var argumentPeriod = traceback.arguments[argumentName];
          if (argumentName === variableName && argumentPeriod === variablePeriod) {
            computedConsumerTracebacks.push(traceback);
          }
        }
      }
      this.computedConsumerTracebacksByVariableId[variableId] = computedConsumerTracebacks.length ?
        computedConsumerTracebacks : null;
    }
    return this.computedConsumerTracebacksByVariableId[variableId];
  },
  getInitialState: function() {
    return {
      columns: null,
      fieldsError: null,
      openedVariableById: {},
      prestations: null,
      showDefaultFormulas: false,
      simulationError: null,
      simulationInProgress: false,
      simulationText: this.props.defaultSimulationText,
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
    this.setState({simulationText: event.target.value});
  },
  handleVariablePanelOpen: function(variableName, variablePeriod) {
    this.handleVariablePanelToggle(variableName, variablePeriod, true);
  },
  handleVariablePanelToggle: function(variableName, variablePeriod, forceValue) {
    var variableId = buildVariableId(variableName, variablePeriod);
    var openedVariableByIdChangeset = {};
    openedVariableByIdChangeset[variableId] = _.isUndefined(forceValue) ?
      ! this.state.openedVariableById[variableId] : forceValue;
    var newOpenedVariableById = update(this.state.openedVariableById, {$merge: openedVariableByIdChangeset});
    this.setState({openedVariableById: newOpenedVariableById});
    if (newOpenedVariableById && ! (variableName in this.state.variableHolderByName)) {
      this.fetchField(variableName);
    }
  },
  render: function() {
    return (
      <div>
        {
          this.state.fieldsError && (
            <div className="alert alert-danger">
              <p>
                <strong>Erreur à l'appel de l'API fields !</strong>
              </p>
              <pre style={{background: 'transparent', border: 0}}>{this.state.fieldsError}</pre>
            </div>
          )
        }
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
                {'URL de l\'API de simulation : ' + this.props.apiUrl + 'api/1/calculate'}
                <span>
                  (<a href={this.props.apiDocUrl + '#calculate'} rel="external" target="_blank">documentation</a>)
                </span>
              </p>
              <textarea
                className="form-control"
                onChange={this.handleSimulationTextChange}
                placeholder="Mettez ici la simulation au format JSON"
                rows={this.state.simulationText.split('\n').length + 1}
                style={{marginBottom: '1em'}}
                value={this.state.simulationText}></textarea>
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
    return (
      this.state.tracebacks.filter(function(traceback) {
        return ! traceback.default_arguments || this.state.showDefaultFormulas;
      }.bind(this)).map(function(traceback) {
        var variable = this.state.variableByName[traceback.name];
        var variableId = buildVariableId(traceback.name, traceback.period);
        var values = _.isArray(variable) ? variable : variable[traceback.period];
        var isOpened = this.state.openedVariableById[variableId];
        var argumentTracebackByName = _(traceback.arguments).keys().map(function(variableName) {
          var variableNameTraceback = _.find(this.state.tracebacks, function(traceback1) {
            return traceback1.name === variableName && traceback1.period === traceback.arguments[variableName];
          });
          return [variableName, variableNameTraceback];
        }.bind(this)).object().valueOf();
        return (
          <VariablePanel
            argumentPeriodByName={traceback.arguments}
            argumentTracebackByName={argumentTracebackByName}
            cellType={traceback.cell_type}
            columns={this.state.columns}
            computedConsumerTracebacks={
              isOpened ? this.findComputedConsumerTracebacks(traceback.name, traceback.period) : null
            }
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
            prestations={this.state.prestations}
            usedPeriods={traceback.used_periods}
            values={values}
            variableByName={this.state.variableByName}
          />
        );
      }.bind(this))
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
    columns: React.PropTypes.object.isRequired,
    computedConsumerTracebacks: React.PropTypes.array,
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
    prestations: React.PropTypes.object.isRequired,
    usedPeriods: React.PropTypes.array,
    values: React.PropTypes.array.isRequired,
    variableByName: React.PropTypes.object.isRequired,
  },
  colorize: function() {
    if (this.props.isOpened && this.props.holder) {
      Rainbow.color();
    }
  },
  componentDidMount: function() {
    this.colorize();
  },
  componentDidUpdate: function() {
    this.colorize();
  },
  getDefaultProps: function() {
    return {
      columns: {},
      prestations: {},
    };
  },
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
              <small>{this.props.period || '-'}</small>
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
                          {formatValue(value, this.props.cellType)}
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
        {this.props.holder.formula && ! this.props.usedPeriods && this.renderFormula(this.props.holder.formula)}
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
                                        {formatValue(value, this.props.cellType)}
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
            <p>Aucune : cette formule n'est appelée par aucune autre formule.</p>
          )
        }
      </div>
    );
  },
  renderFormula: function(formula) {
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
          <ul>
            {
              formula.alternative_formulas.map(function(alternativeFormula, idx) {
                return <li key={idx}>{this.renderFormula(alternativeFormula)}</li>;
              }.bind(this))
            }
          </ul>
        </div>
      );
    } else if (formula['@type'] === 'DatedFormula') {
      return (
        <div>
          <h3>DatedFormula <small>Fonctions datées</small></h3>
          {
            formula.doc && (
              <div>
                <h3>Description</h3>
                <pre>{formula.doc}</pre>
              </div>
            )
          }
          <ul>
            {
              formula.dated_formulas.map(function(datedFormula, idx) {
                return (
                  <li key={idx}>
                    <span className="lead">{datedFormula.start_instant} - {datedFormula.stop_instant}</span>
                    {this.renderFormula(datedFormula.formula)}
                  </li>
                );
              }.bind(this))
            }
          </ul>
        </div>
      );
    } else if (formula['@type'] === 'SelectFormula') {
      var variableId = buildVariableId(this.props.name, this.props.period),
        accordionId = 'accordion-' + variableId;
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
                var isCalled = this.props.argumentPeriodByName &&
                  formula.variables[0].name in this.props.argumentPeriodByName; // This is tricky.
                var mainVariableId = accordionId + '-' + mainVariable;
                var headingId = mainVariableId + '-heading';
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
                          {mainVariable + (isCalled ? '' : ' (non appelée)')}
                        </a>
                      </h4>
                    </div>
                    <div
                      aria-labelledby={headingId}
                      className={cx({collapse: true, in: isCalled, 'panel-collapse ': true})}
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
                <th className="text-right">Valeur</th>
              </tr>
            </thead>
            <tbody>
              {
                formula.variables.map(function(variable, idx) {
                  var argumentPeriod = this.props.argumentPeriodByName &&
                    this.props.argumentPeriodByName[variable.name],
                    argumentValues = _.isArray(this.props.variableByName[variable.name]) ?
                      this.props.variableByName[variable.name] :
                      this.props.variableByName[variable.name][argumentPeriod];
                  return (
                    <tr key={idx}>
                      <td>
                        <VariableLink name={variable.name} onOpen={this.props.onOpen} period={argumentPeriod}>
                          {variable.name}
                        </VariableLink>
                      </td>
                      <td>{argumentPeriod}</td>
                      <td>{variable.label !== variable.name ? variable.label : ''}</td>
                      <td>
                        <span className={cx('label', 'label-' + getEntityBackgroundColor(variable.entity))}>
                          {variable.entity}
                        </span>
                      </td>
                      <td>
                        {
                          argumentValues && (
                            <ul className="list-unstyled">
                              {
                                argumentValues.map(function(value, idx) {
                                  var column = this.props.columns[variable.name],
                                    prestation = this.props.prestations[variable.name];
                                  var isDefaultArgument = this.props.hasAllDefaultArguments ||
                                    column && column.default == value ||
                                    prestation && prestation.default == value;
                                  var valType = this.props.argumentTracebackByName &&
                                    this.props.argumentTracebackByName[variable.name] ?
                                    this.props.argumentTracebackByName[variable.name].cell_type :
                                    null;
                                  var formattedValue = formatValue(value, valType);
                                  return (
                                    <li className="text-right" key={idx}>
                                      <samp>
                                        {
                                          isDefaultArgument ? formattedValue : (
                                            <span className='bg-danger'>{formattedValue}</span>
                                          )
                                        }
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
          <div style={{position: 'relative'}}>
            <h3>Code source</h3>
            <pre>
              <code data-language="python">{formula.source}</code>
            </pre>
            <a href={githubUrl} rel="external" style={{position: 'absolute', right: 7, top: 5}} target="_blank">
              Voir dans GitHub
            </a>
          </div>
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
