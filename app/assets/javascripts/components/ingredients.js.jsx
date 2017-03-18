class Ingredients extends React.Component {
  constructor(props) {
    super(props);
    this.state = {ingredients: this.props.data};
  }

  render() {
    const items = renderIngredients(this.state.ingredients);

    return (
      <div className="ingredients card p-1 mb-sm-3">
        <div className="card-header mb-2">
          <h1 className="title">Pantry</h1>
        </div>
        <table className="table table-bordered table-hover">
          <thead className="thead-default">
            <tr>
              <th>Name</th>
              <th>Amount</th>
              <th>Units</th>
            </tr>
          </thead>
          <tbody>
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

const Ingredient = ({ item_id, ingredient }) => {
  return(
    <tr key={item_id}>
      <td>{ingredient.name}</td>
      <td>{ingredient.amount}</td>
      <td>{ingredient.unit}</td>
    </tr>
  );
}
