import React from 'react';
import { logout } from '../../actions/authActions.js';
import store from '../../store.js';


class LogoutButton extends React.Component {


  logout = () => {
    store.dispatch(logout()).then(() => {
      this.context.router.push('/admin/login');
    });
  }

  render() {
    return (
      <a onClick={this.logout}>
        <span>Logout</span>
      </a>
    );
  }
}

LogoutButton.contextTypes = {
  router: React.PropTypes.object.isRequired
};

export default LogoutButton;
