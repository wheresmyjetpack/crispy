class ShoppingList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: ['input-0', 'input-1', 'input-2']
    };
  }

  render() {
    return (
    <div className="card w-50 p-4">
      <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post">
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
    return this.state.inputs.map((inputName, index) => {
      let divName = 'shoppingItem-' + index;
      return (
        <div className="shopping-item" key={divName}>
          <input name="shopping_list[]" key={inputName} className="form-control my-2" />
          <button type="button" className="btn btn-danger m-2" onClick={ () => this.removeInput(inputName) }>
            - Item
          </button>
        </div>
      );
    });
  }

  appendInput() {
    let newInput = `input-${this.state.inputs.length}`;
    this.setState({ inputs: this.state.inputs.concat([newInput]) });
  }

  appendShoppingItem() {
    let newDiv = `shopping-item-${this.state.inputs.length}`;
    this.setState({ shoppingItems: this.state.inputs.concat([newDiv]) });
    this.appendInput();
  }

  removeInput(inputName) {
    this.setState(
      {
        inputs: this.state.inputs.filter( (item) => {
          return item !== inputName;
        })
      }
    );
  }
}
