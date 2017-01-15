class ShoppingList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {inputs: ['input-0', 'input-1', 'input-2']};
  }

  render() {
    return (
    <div className="card w-50 p-4">
      <form role="form" acceptCharset="UTF-8" action="/shopping_list" method="post">
        <input type="hidden" name="authenticity_token" value={this.props.authenticity_token} />
        { this.state.inputs.map(input => <input name="shopping_list[]" key={input} className="form-control m-2" />) }
        <hr />
        <button type="button" className="btn btn-primary m-2" onClick={ () => this.appendInput() }>
          + Item
        </button>
        <input type="submit" className="btn btn-success m-2" />
      </form>
    </div>
    );
  }

  appendInput() {
    let newInput = `input-${this.state.inputs.length}`;
    this.setState({ inputs: this.state.inputs.concat([newInput]) });
  }

  removeInput() {
    
  }
}
