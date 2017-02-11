const shortid = require('shortid');

class FinalizedShoppingListContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {items: this.props.data};
  }

  render() {
    return <FinalizedShoppingList items={this.state.items} authToken={this.props.authToken}/>;
  }
}

class FinalizedShoppingList extends React.Component {
  render() {
    return (
      <div className="p-4 w-50">
        <h2>
          Shopping List
        </h2>
        <hr />
        <form role="form" action="/shopping_list/persist" method="post" className="p-3">
          <input type="hidden" name="authenticity_token" value={this.props.authToken} />
          {this.renderItems()}
          <input type="submit" className="btn btn-success mt-2" />
          <a className="btn btn-danger mt-2" href="/shopping_list" data-method="delete" rel="nofollow">
            Cancel
          </a>
        </form>
      </div>
    );
  }

  renderItems() {
    return this.props.items.map((itm) => {
      let elemKey = shortid.generate();
      return <ShoppingItem key={elemKey} name={itm.name} itemId={elemKey} amount={itm.amount} />;
    });
  }
}

class ShoppingItem extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      checked: false
    }

    this.toggleChecked = this.toggleChecked.bind(this)
  }

  render() {
    let itemName = titleize(this.props.name)
    let label = `${this.props.amount} ${this.props.name}`
    let hiddenFields = (this.state.checked ? this.addHiddenFields(this.props.itemId, itemName) : null)

    return this.present(label, this.state.checked, this.toggleChecked, hiddenFields)
  }

  present(label, checked, handleCheck, hiddenFields) {

    return (
      <div className="form-check mb-2 mr-sm-2 mb-sm-0">
        <label className="form-check-label">
          <input className="form-check-input mr-2" type="checkbox" defaultChecked={checked} onChange={handleCheck} />
          {checked ? hiddenFields : null}
          {label}
        </label>
      </div>
    );
  }

  addHiddenFields(elemId, itemName) {
    let ingredientsParams = `ingredients[]`;
    let ingredientInputName = `${ingredientsParams}name`;
    let amountInputName = `${ingredientsParams}amount`;

    return (
      <div key={elemId}>
        <input type="hidden" name={ingredientInputName} value={itemName} />
        <input type="hidden" name={amountInputName} value={this.props.amount} />
      </div>
    )
  }

  toggleChecked(e) {
    this.setState({
      checked: e.target.checked
    })
  }
}

function titleize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
}

module.exports = FinalizedShoppingListContainer
