class Ingredients extends React.Component {
  constructor(props) {
    super(props);
    this.state = {ingredients: this.props.data};
  }

  render() {
    const items = renderIngredients(this.state.pantryItems);

    return (
      <div className="ingredients">
        <h2 className="title">Pantry</h2>
        <table className="table table-bordered">
          <tbody>
            <tr>
              <th>Name</th>
            </tr>
            {items}
          </tbody>
        </table>
      </div>
    );
  }
}

function renderIngredients(items) {
  return items.map((itm) => {
    return <Ingredient key={itm.id} ingredient={itm} />;
  });
}
