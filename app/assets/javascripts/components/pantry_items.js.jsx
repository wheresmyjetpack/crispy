class PantryItems extends React.Component {
  constructor(props) {
    super(props);
    this.state = {pantryItems: this.props.data};
  }

  render() {
    const items = renderPantryItems(this.state.pantryItems);

    return (
      <div className="pantry-items">
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

function renderPantryItems(items) {
  return items.map((itm) => {
    return <PantryItem key={itm.id} pantryItem={itm} />;
  });
}
