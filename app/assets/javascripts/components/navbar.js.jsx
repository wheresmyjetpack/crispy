class NavbarContainer extends React.Component {
  constructor(props) {
    super(props) 
    this.state = {
      userLoggedIn: this.props.userLoggedIn
    }
  }

  render() {
    const isLoggedIn = this.state.userLoggedIn;

    if (isLoggedIn) {
      return ( 
        <Navbar userLoggedIn={this.state.userLoggedIn} rootUri={this.props.rootUri} pantryUri={this.props.pantryUri} />
      );
    } else {
      return <Navbar />;
    }
  }
}

class Navbar extends React.Component {
  render() {
    return (
      <header className="navbar" id="fixed-navbar">
        <div className="container">
          {this.navItems()}
        </div>
      </header>
    );
  }

  navItems() {
    const isLoggedIn = this.props.userLoggedIn;

    if (isLoggedIn) {
      return <LoggedInNav rootUri={this.props.rootUri} pantryUri={this.props.pantryUri} />;
    } else {
      return <LoggedOutNav />;
    }
  }
}

const LoggedInNav = ({ rootUri, pantryUri }) => (
  <nav className="nav justify-content-end logged-in">
    <a href={rootUri} className="nav-link">Home</a>
    <a href="/shopping_list/new" className="nav-link">Go Shopping</a>
    <div className="nav-item dropdown dropdown-menu-right">
      <a className="nav-link dropdown-toggle" data-toggle="dropdown"
        href="#" role="button" aria-haspopup="true"
        aria-expanded="false">Profile</a>
      <div className="dropdown-menu">
        <a href={pantryUri} className="nav-link dropdown-item">View Pantry</a>
        <a href="#" className="nav-link dropdown-item">Settings</a>
        <a href="/logout" className="nav-link dropdown-item" data-method="delete">Logout</a>
      </div>
    </div>
  </nav>
);

const LoggedOutNav = () => (
  <nav className="nav justify-content-end logged-out">
    <a href="/login" className="nav-link">Log In</a>
    <a href="#" className="nav-link">Sign Up</a>
  </nav>
);

module.exports = NavbarContainer
