class Navbar extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      userLoggedIn: this.props.userLoggedIn,
      currentUserId: this.props.currentUserId
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
      return <LoggedInNav userId={this.state.currentUserId} />;
    } else {
      return <LoggedOutNav />;
    }
  }
}

class LoggedInNav extends React.Component {
  render() {
    let userProfileUri = `/users/${this.props.userId}`;
    return (
      <nav className="nav justify-content-end logged-in">
        <a href="/ingredients" className="nav-link">Home</a>
        <a href="/shopping_list/new" className="nav-link">Go Shopping</a>
        <div className="nav-item dropdown dropdown-menu-right">
          <a className="nav-link dropdown-toggle" data-toggle="dropdown" href="#" role="button" aria-haspopup="true" aria-expanded="false">Profile</a>
          <div className="dropdown-menu">
            <a href={userProfileUri} className="nav-link dropdown-item">View Profile</a>
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
        <a href="/login" className="nav-link">Log In</a>
        <a href="#" className="nav-link">Sign Up</a>
      </nav>
    );
  }
}

module.exports = Navbar
