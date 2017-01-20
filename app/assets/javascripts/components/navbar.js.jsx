class Navbar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      userLoggedIn: this.props.data
    }
  }

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
    const isLoggedIn = this.state.userLoggedIn;

    if (isLoggedIn) {
      return <LoggedInNav />;
    } else {
      return <LoggedOutNav />;
    }
  }
}

class LoggedInNav extends React.Component {
  render() {
    return (
      <nav className="nav justify-content-end logged-in">
        <a href="/ingredients" className="nav-link">Home</a>
        <a href="/shopping_list/new" className="nav-link">Go Shopping</a>
        <div className="nav-item dropdown dropdown-menu-right">
          <a className="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Profile</a>
          <div className="dropdown-menu">
            <a href="/logout" className="nav-link dropdown-item" data-method="delete">Logout</a>
            <a href="#" className="nav-link dropdown-item">Settings</a>
          </div>
        </div>
      </nav>
    );
  }
}

class LoggedOutNav extends React.Component {
  render() {
    return (
      <nav className="nav justify-content-end logged-out">
        <a href="/login" className="nav-link">Sign In</a>
        <a href="#" className="nav-link">Sign Up</a>
      </nav>
    );
  }
}

module.exports = Navbar
