class PantryItem extends React.Component {
  render() {
    return(
      <tr key={this.props.id}>
        <td>{this.props.pantryItem.name}</td>
      </tr>
    );
  }
}
