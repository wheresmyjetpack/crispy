const shortid = require('shortid');

class ShoppingListContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: Array.from(initializeInputs(6, this.handleRemove.bind(this)))
    };
  }

  render() {
    return (
      <ShoppingList
        inputs={this.state.inputs}
        handleOnClick={this.handleAdd.bind(this)}
        authToken={this.props.authenticityToken}/>
      );
  } 

  handleAdd() {
    let elementKey = shortid.generate();
    let callback = this.handleRemove.bind(this);
    this.setState({
      inputs: this.state.inputs.concat([<ShoppingItem key={elementKey} name={elementKey} handleOnClick={callback} />])
    });
  }

  handleRemove(element) {
    this.setState({
      inputs: this.state.inputs.filter( (input) => {
        return input.props.name !== element.props.name;
      })
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
  render() {
    let inputName = `shopping_list[${this.props.name}][name]`;
    let inputAmt = `shopping_list[${this.props.name}][amount]`;

    return (
      <div className="row form-group">
        <div className="col-sm-6">
          <input name={inputName} className="form-control" />
        </div>
        <div className="col-sm-2">
          <input name={inputAmt} className="form-control" type="text" />
        </div>
        <div className="col-sm-4">
          <button type="button"
            className="btn btn-outline-danger"
            onClick={ () => this.props.handleOnClick(this) } >
            - Item
          </button>
        </div>
      </div>
      );
  }
}

const initializeInputs = function*(n, callback) {
  for (let i = 0; i < n; i++) {
    let elementKey = shortid.generate();
    yield (
      <ShoppingItem key={elementKey} name={elementKey} handleOnClick={callback} />
      );
  }
}

module.exports = ShoppingListContainer
