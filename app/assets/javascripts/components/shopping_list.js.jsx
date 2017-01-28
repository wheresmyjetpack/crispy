const shortid = require('shortid');

class ShoppingListContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: [shortid.generate(), shortid.generate(), shortid.generate(), shortid.generate()]
    };
  }

  render() {
    return (
      <ShoppingList
        inputs={this.state.inputs}
        handleButtonClick={this.handleAdd.bind(this)}
        handleRemove={this.handleRemove.bind(this)}
        authenticityToken={this.props.authenticityToken}/>
    );
  } 

  handleAdd() {
    let newInput = shortid.generate();
    this.setState({
      inputs: this.state.inputs.concat([newInput])
    });
  }

  handleRemove(inputName) {
    this.setState({
      inputs: this.state.inputs.filter( (input) => {
        return input !== inputName;
      })
    });
  }
}

class ShoppingList extends React.Component {
  render() {
    return (
      <div className="p-4 mt-sm-3 mb-sm-4">
        <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post" className="p-md-3">
          <input type="hidden" name="authenticity_token" value={this.props.authenticityToken} />
          {this.renderInputs()}
          <hr />
          <div className="row">
            <div className="col-lg-4 col-xs-12">
              <button type="button" className="btn btn-primary mt-sm-2" onClick={ () => this.props.handleButtonClick() }>
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
    return this.props.inputs.map((inputName) => {
      return <ShoppingItem key={inputName} name={inputName} handleButtonClick={this.props.handleRemove} />
    });
  }
}

class ShoppingItem extends React.Component {
  render() {
    return (
      <div className="row" key={this.props.inputName}>
        <div className="col-lg-6 col-md-8 col-xs-12">
          <div className="shopping-item input-group mr-sm-2">
            <input name="shopping_list[]" className="form-control my-2" />
            <button type="button" className="btn btn-outline-danger m-2" onClick={ () => this.props.handleButtonClick(this.props.name) }>
              - Item
            </button>
          </div>
        </div>
      </div>
    );
  }
}

module.exports = ShoppingListContainer
