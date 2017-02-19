const shortid = require('shortid');
const measurementEndpoint = '/api/v1/measurements.json';

class ShoppingListContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: Array.from(initializeInputs(6, this.handleBlur.bind(this), this.handleRemove.bind(this))),
      hasDanger: []
    };
  }

  render() {
    let inputs = this.state.inputs.map( (input) => {
      if (this.state.hasDanger.includes(input.props.name)) {
        return this.newInput(
          input.props.name,
          input.props.handleOnClick,
          input.props.handleBlur,
          true
        );
      } else {
        return input;
      }
    });
    return (
      <ShoppingList
        inputs={inputs}
        handleOnClick={this.handleAdd.bind(this)}
        authToken={this.props.authenticityToken}/>
      );
  }

  handleAdd() {
    let elementKey = shortid.generate();
    let onRemove = this.handleRemove.bind(this);
    let handleOnBlur = this.handleBlur.bind(this);
    this.setState({
      inputs: this.state.inputs.concat([this.newInput(elementKey, onRemove, handleOnBlur, false)])
    });
  }

  newInput(elementKey, onRemove, handleOnBlur, hasDanger) {
    return (
    <ShoppingItem
        key={elementKey}
        name={elementKey}
        hasDanger={hasDanger}
        handleOnClick={onRemove}
        handleBlur={handleOnBlur}/>
    );
  }

  handleRemove(element) {
    this.setState({
      inputs: this.state.inputs.filter( (input) => {
        return input.props.name !== element.props.name;
      })
    });
  }

  handleBlur(context, e) {
    let amount = e.target.value;

    if (amount === '') {
      return;
    }

    $.ajax(measurementEndpoint, {
      data: {
        measurement: amount
      },
      success: (data) => {
        if (!data) {
          this.setState({
            hasDanger: (this.state.hasDanger.includes(context) ? this.state.hasDanger : this.state.hasDanger.concat(context))
          });
        } else {
          this.setState({
            hasDanger: this.state.hasDanger.filter( (name) => {
              return name !== context
            })
          });
        }
      },
      error: () => { console.log('AJAX request failed') }
    });
  }
}

const ShoppingList = ({ inputs, handleOnClick, authToken }) => {
  return (
    <div className="p-4 mt-sm-3 mb-sm-4">
      <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post" className="p-md-3">
        <input type="hidden" name="authenticity_token" value={authToken} />
        {inputs.map((input) => (input))}
        <hr />
        <div className="row">
          <div className="col-lg-4 col-xs-12">
            <button type="button" className="btn btn-primary mt-sm-2" onClick={ () => handleOnClick() }>
              + Item
            </button>
            <input type="submit" className="btn btn-success mt-sm-2" />
          </div>
        </div>
      </form>
    </div>
  );
}

class ShoppingItem extends React.Component {
  passEventContext(e) {
    this.props.handleBlur(this.props.name, e)
  }

  render() {
    let inputName = `shopping_list[${this.props.name}][name]`;
    let inputAmt = `shopping_list[${this.props.name}][amount]`;
    let amtClasses = 'form-control';
    let amtWrapperClasses = 'form-group col-sm-2';

    if (this.props.hasDanger) {
      amtClasses = 'form-control form-control-danger';
      amtWrapperClasses = 'form-group has-danger col-sm-2';
    }

    return (<div className="row form-group">
      <div className="col-sm-6">
        <input name={inputName} className="form-control" />
      </div>
      <div className={amtWrapperClasses}>
        <input name={inputAmt} className={amtClasses} type="text" onBlur={ (e) => this.passEventContext(e) } />
      </div>
      <div className="col-sm-4">
        <button type="button"
          className="btn btn-outline-danger"
          onClick={ () => this.props.handleOnClick(this) } > - Item</button>
      </div>
    </div>);
  }
}

const initializeInputs = function*(n, handleOnBlur, handleClick) {
  for (let i = 0; i < n; i++) {
    let elementKey = shortid.generate();
    yield (
      <ShoppingItem hasDanger={false} key={elementKey} name={elementKey} handleBlur={handleOnBlur} handleOnClick={handleClick} />
      );
  }
}

module.exports = ShoppingListContainer
