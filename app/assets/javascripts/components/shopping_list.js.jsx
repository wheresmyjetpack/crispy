const shortid = require('shortid');

class ShoppingList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: [shortid.generate(), shortid.generate(), shortid.generate(), shortid.generate()]
    };
  }

  render() {
    return (
    <div className="p-4 mt-sm-3 mb-sm-4">
      <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post" className="p-md-3">
        <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
        {this.renderInputs()}
        <hr />
        <div className="row">
          <div className="col-lg-4 col-xs-12">
            <button type="button" className="btn btn-primary mt-sm-2" onClick={ () => this.appendShoppingItem() }>
              + Item
            </button>
            <input type="submit" className="btn btn-success mt-sm-2" />
          </div>
        </div>
      </form>
    </div>
    );
  }

  renderInputs() {
    return this.state.inputs.map((inputName) => {
      return (
        <div className="row" key={inputName}>
          <div className="col-lg-6 col-md-8 col-xs-12">
            <div className="shopping-item input-group mr-sm-2">
              <input name="shopping_list[]" className="form-control my-2" />
              <button type="button" className="btn btn-outline-danger m-2" onClick={ () => this.removeInput(inputName) }>
                - Item
              </button>
            </div>
          </div>
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
    this.setState({
      inputs: this.state.inputs.filter( (input) => {
        return input !== inputName;
      })
    });
  }
}

module.exports = {
  ShoppingList: ShoppingList
}
