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
      return <ShoppingItem key={shortid.generate()} name={itm.name} amount={itm.amount} />;
    });
  }
}

class ShoppingItem extends React.Component {
  render() {
    let inputName = `ingredients[${titleize(this.props.name)}]`;
    let label = `${this.props.amount} ${this.props.name}`
    return (
        <div className="form-check mb-2 mr-sm-2 mb-sm-0">
          <label className="form-check-label">
            <input className="form-check-input mr-2" type="checkbox" name={inputName} />
            {label}
          </label>
        </div>
    );
  }
}

function titleize(string) {
  return string.charAt(0).toUpperCase() + string.slice(1).toLowerCase();
}

module.exports = FinalizedShoppingListContainer
