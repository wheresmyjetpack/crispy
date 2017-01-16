const shortid = require('shortid');

class ShoppingList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      inputs: [shortid.generate(), shortid.generate(), shortid.generate()],
      divs: [shortid.generate(), shortid.generate(), shortid.generate()]
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
    let divInputNames = this.state.inputs.map((input, index) => ( [input, this.state.divs[index]] ));

    return divInputNames.map(([inputName, divName]) => {
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

  appendShoppingItem() {
    let newDiv = shortid.generate();
    let newInput = shortid.generate();
    this.setState({
      divs: this.state.inputs.concat([newDiv]),
      inputs: this.state.inputs.concat([newInput])
    });
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

module.exports = {
  ShoppingList: ShoppingList
}
