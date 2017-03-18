class Ingredient extends React.Component {
  render() {
    return(
      <tr key={this.props.id}>
        <td>{this.props.ingredient.name}</td>
        <td>{this.props.ingredient.amount}</td>
        <td>{this.props.ingredient.unit}</td>
      </tr>
    );
  }
}
