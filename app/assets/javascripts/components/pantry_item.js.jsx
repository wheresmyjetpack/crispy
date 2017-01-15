class Ingredient extends React.Component {
  render() {
    return(
      <tr key={this.props.id}>
        <td>{this.props.ingredient.name}</td>
      </tr>
    );
  }
}
