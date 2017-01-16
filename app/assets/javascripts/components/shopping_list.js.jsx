const shortid = require('shortid');

class ShoppingList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: [shortid.generate(), shortid.generate(), shortid.generate()]
    };
  }

  render() {
    return (
    <div className="card w-50 p-4 mt-sm-3 mb-sm-4">
      <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post" className="form-inline">
        <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
        {this.renderInputs()}
        <hr />
        <button type="button" className="btn btn-primary m-2" onClick={ () => this.appendShoppingItem() }>
          + Item
        </button>
        <input type="submit" className="btn btn-success m-2" />
      </form>
    </div>
    );
  }


  renderInputs() {
    return this.state.inputs.map((inputName) => {
      return (
        <div className="shopping-item input-group mr-sm-2" key={inputName}>
          <input name="shopping_list[]" className="form-control my-2" />
          <button type="button" className="btn btn-danger m-2" onClick={ () => this.removeInput(inputName) }>
            - Item
          </button>
        </div>
      );
    });
  }

  appendShoppingItem() {
    let newInput = shortid.generate();
    this.setState({
      inputs: this.state.inputs.concat([newInput])
    });
  }

  removeInput(inputName) {
    this.setState(
      {
        inputs: this.state.inputs.filter( (input) => {
          return input !== inputName;
        })
      }
    );
  }
}

module.exports = {
  ShoppingList: ShoppingList
}
