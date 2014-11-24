/** @jsx React.DOM */
'use strict';

var $ = window.$,
  Rainbow = window.Rainbow,
  React = window.React;

var cx = React.addons.classSet,
  update = React.addons.update;


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
  .done(function (data, textStatus, jqXHR) {
    onSuccess(data);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    onError(jqXHR.responseText);
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
  .done(function(data, textStatus, jqXHR) {
    onSuccess(data);
  })
  .fail(function(jqXHR, textStatus, errorThrown) {
    onError(jqXHR.responseText);
  });
}


function getEntityBackgroundColor(entity) {
  return {
    fam: 'bg-success',
    familles: 'bg-success',
    foy: 'bg-info',
    foyers_fiscaux: 'bg-info',
    ind: 'bg-primary',
    individus: 'bg-primary',
    men: 'bg-warning',
    menages: 'bg-warning',
  }[entity] || entity;
};


function getEntityKeyPlural(entity) {
  return {
    fam: 'familles',
    foy: 'foyers fiscaux',
    ind: 'individus',
    men: 'ménages',
  }[entity] || entity;
};


function mapObject(obj, cb) {
  var result = [];
  for (var key in obj) {
    var value = obj[key];
    result.push(cb(key, value));
  }
  return result;
}


var TraceTool = React.createClass({
  propTypes: {
    apiDocUrl: React.PropTypes.string.isRequired,
    apiUrl: React.PropTypes.string.isRequired,
    defaultSimulationText: React.PropTypes.string,
  },
  calculate: function() {
    try {
        var simulationJson = JSON.parse(this.state.simulationText);
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
      var computedVariablesTracebacks = firstScenarioTracebacks.filter(function(traceback) {
        return traceback.is_computed;
      });
      this.computedConsumerTracebacksByVariableId = {};
      this.setState({
        simulationError: null,
        simulationInProgress: false,
        simulationText: this.props.defaultSimulationText,
        tracebacks: computedVariablesTracebacks,
        variableByName: firstScenarioVariables,
      });
    }.bind(this);
    this.setState({simulationInProgress: true}, function() {
      calculate(this.props.apiUrl, simulationJson, onSuccess, onError);
    });
  },
  componentDidMount: function() {
    this.calculate();
  },
  findComputedConsumerTracebacks: function(variableName, variablePeriod) {
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
      openedVariableById: {},
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
  handleVariablePanelToggle: function(variableName, variablePeriod) {
    var variableId = variableName + '-' + variablePeriod;
    var openedVariableByIdChangeset = {};
    openedVariableByIdChangeset[variableId] = ! this.state.openedVariableById[variableId];
    var newopenedVariableById = update(this.state.openedVariableById, {$merge: openedVariableByIdChangeset});
    this.setState({openedVariableById: newopenedVariableById});

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
  render: function() {
    return (
      <div>
        {this.renderSimulationForm()}
        {
          this.state.simulationError && (
            <div className="alert alert-danger">
              <p>
                <strong>Erreur !</strong>
              </p>
              <pre style={{background: 'transparent', border: 0}}>{this.state.simulationError}</pre>
            </div>
          )
        }
        {
          this.state.tracebacks && this.state.tracebacks.map(function(traceback) {
            var variable = this.state.variableByName[traceback.name];
            var variableId = traceback.name + '-' + traceback.period;
            var values = typeof variable === 'object' ? variable[traceback.period] : variable;
            var isOpened = this.state.openedVariableById[variableId];
            return ! traceback.default_arguments || this.state.showDefaultFormulas ? (
              <VariablePanel
                computedConsumerTracebacks={
                  isOpened ? this.findComputedConsumerTracebacks(traceback.name, traceback.period) : null
                }
                entity={traceback.entity}
                holder={this.state.variableHolderByName[traceback.name]}
                holderError={this.state.variableHolderErrorByName[traceback.name]}
                isOpened={isOpened}
                key={variableId}
                label={traceback.label}
                name={traceback.name}
                onToggle={this.handleVariablePanelToggle}
                period={traceback.period}
                values={values}
                variableByName={this.state.variableByName}
                variablePeriodByName={traceback.arguments}
              />
            ) : null;
          }.bind(this))
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
              <a className="" data-toggle="collapse" href="#collapseSimulationText" aria-expanded="true"
                aria-controls="collapseSimulationText">
                Appel de la simulation
              </a>
            </h4>
          </div>
          <div id="collapseSimulationText" className="panel-collapse collapse" role="tabpanel"
            aria-labelledby="collapseSimulationTextHeading" aria-expanded="true">
            <div className="panel-body">
              <p>
                URL de l'API de simulation : {this.apiUrl + 'api/1/calculate '}
                (<a href={this.props.apiDocUrl + '#calculate'} rel="external" target="_blank">documentation</a>)
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
            Afficher aussi les formules appelées avec les valeurs par défaut
          </label>
        </div>
        {
          this.state.simulationInProgress && (
            <div className="alert alert-info">
              <p>Simulation en cours...</p>
            </div>
          )
        }
      </form>
    );
  },
});


var VariablePanel = React.createClass({
  propTypes: {
    computedConsumerTracebacks: React.PropTypes.array,
    entity: React.PropTypes.string.isRequired,
    holder: React.PropTypes.object,
    holderError: React.PropTypes.string,
    isOpened: React.PropTypes.bool,
    label: React.PropTypes.string.isRequired,
    name: React.PropTypes.string.isRequired,
    onToggle: React.PropTypes.func.isRequired,
    period: React.PropTypes.string.isRequired,
    values: React.PropTypes.array.isRequired,
    variableByName: React.PropTypes.object.isRequired,
    variablePeriodByName: React.PropTypes.object.isRequired,
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
  handlePanelHeadingClick: function(event) {
    this.props.onToggle(this.props.name, this.props.period);
  },
  render: function() {
    return (
      <div className="panel panel-default" id={this.props.name + '-' + this.props.period}>
        <div className="panel-heading" onClick={this.handlePanelHeadingClick} style={{cursor: 'pointer'}}>
          <div className="row">
            <div className="col-sm-3">
              <span className={cx('glyphicon', this.props.isOpened ? 'glyphicon-minus' : 'glyphicon-plus')}></span>
              <code>{this.props.name}</code>
            </div>
            <div className="col-sm-5">{this.props.label}</div>
            <div className={cx('col-sm-1', getEntityBackgroundColor(this.props.entity))}>
              {getEntityKeyPlural(this.props.entity)}
            </div>
            <div className="col-sm-1">{this.props.period}</div>
            <div className="col-sm-2">
              <ul className="list-unstyled">
                {
                  this.props.values.map(function(value, idx) {
                    <li className="text-right" key={idx}>{value}</li>
                  })
                }
              </ul>
            </div>
          </div>
        </div>
        {
          this.props.isOpened && (
            <div className="panel-body">
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
            </div>
          )
        }
      </div>
    );
  },
  renderBody: function() {
    return (
      <div>
        {this.renderFormula(this.props.holder.formula)}
        <h3>Formules dépendantes</h3>
        {
          this.props.computedConsumerTracebacks ? (
            <ul className="consumers">
              {
                this.props.computedConsumerTracebacks.map(function(computedConsumerTraceback, idx) {
                  var computedConsumerTracebackId = computedConsumerTraceback.name + '-' +
                    computedConsumerTraceback.period;
                  return (
                    <li key={idx}>
                      <a href={'#' + computedConsumerTracebackId}>{computedConsumerTraceback.name}</a>
                      <span> : {computedConsumerTraceback.label}</span>
                    </li>
                  );
                }.bind(this))
              }
            </ul>
          ) : (
            <p>Aucune</p>
          )
        }
      </div>
    );
  },
  renderFormula: function(formula) {
    if (formula['@type'] === 'AlternativeFormula') {
      return (
        <div>
          <h3>Choix de fonctions <small>AlternativeFormula</small></h3>
          <ul>
            {
              formula.alternative_formulas.map(function(alternativeFormula, idx) {
                return <li key={idx}>{this.renderFormula(alternativeFormula)}</li>;
              }.bind(this))
            }
          </ul>
        </div>
      )
    } else if (formula['@type'] === 'DatedFormula') {
      return (
        <div>
          <h3>Fonctions datées <small>DatedFormula</small></h3>
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
      return (
        <div>
          <h3>Choix de fonctions <small>SelectFormula</small></h3>
          <ul>
            {
              mapObject(formula.formula_by_main_variable, function(mainVariable, formula) {
                var isCalled = formula.variables[0].name in this.props.variablePeriodByName; // This is tricky.
                return (
                  <li key={mainVariable}>
                      <span className="lead">{mainVariable} {isCalled ? null : '(non appelée)'}</span>
                      {this.renderFormula(formula)}
                  </li>
                );
              }.bind(this))
            }
          </ul>
        </div>
      );
    } else if (formula['@type'] === 'SimpleFormula') {
      var githubUrl = 'https://github.com/openfisca/openfisca-france/tree/master/' +
        formula.module.split('.').join('/') + '.py#L' + formula.line_number + '-' +
        (formula.line_number + formula.source.trim().split('\n').length - 1);
      return (
        <div>
          <h3>Fonction <small>SimpleFormula</small></h3>
          <h4>Paramètres</h4>
          <table className="table">
            <thead>
              <tr>
                <th>Nom</th>
                <th>Libellé</th>
                <th>Entité</th>
                <th>Période</th>
                <th>Valeur</th>
              </tr>
            </thead>
            <tbody>
              {
                formula.variables.map(function(variable, idx) {
                  var argumentPeriod = this.props.variablePeriodByName[variable.name],
                    argumentValue = this.props.variableByName[variable.name],
                    argumentArray = typeof argumentValue === 'object' ? argumentValue[argumentPeriod] : argumentValue,
                    variableId = variable.name + '-' + argumentPeriod;
                  return (
                    <tr key={idx}>
                      <td><a href={'#' + variableId}>{variable.name}</a></td>
                      <td>{variable.label != variable.name ? variable.label : ''}</td>
                      <td className={getEntityBackgroundColor(variable.entity)}>{variable.entity}</td>
                      <td>{argumentPeriod}</td>
                      <td>
                        {
                          argumentArray && (
                            <ul className="list-unstyled">
                              {
                                argumentArray.map(function(argument, idx) {
                                  return <li className="text-right" key={idx}>{argument}</li>;
                                })
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
          <h4>Code source</h4>
          <a className="btn btn-info" href={githubUrl} rel="external" target="_blank">Voir dans GitHub</a>
          <pre><code data-language="python">{formula.source}</code></pre>
        </div>
      )
    }
  },
});



var mountNode = document.getElementById('trace-container');
React.render(
  <TraceTool
    apiDocUrl={window.apiDocUrl}
    apiUrl={window.apiUrl}
    defaultSimulationText={window.defaultSimulationText}
  />,
  mountNode
);
