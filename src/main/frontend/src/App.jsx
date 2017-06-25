import React, { Component } from 'react';
import { connect } from 'react-redux';
import { injectIntl } from 'react-intl';
import 'sweetalert2/dist/sweetalert2.css';
import 'bootstrap/dist/css/bootstrap.css';
import 'bootstrap/dist/css/bootstrap-theme.css';
import 'font-awesome/css/font-awesome.css';
import 'react-select/dist/react-select.css';
import './stylesheets/App.css';
import Header from './components/header/Header.jsx';
import  '../assets/css/page.css';
import { setCurrentUser } from './actions/authActions';


const client = require('rest');

class App extends Component {

  constructor() {
    super();
    this.state = {
      redirectTo: window.location.pathname,
      loading: true
    };
  }

  componentDidMount() {
    client({
      path: '/api/me'
    }).done(res => {
      this.setState({ loading: false });
      if (res.status.code === 200) {
        this.props.setCurrentUser(JSON.parse(res.entity));
        this.context.router.push(this.state.redirectTo);
      } else {
        this.props.setCurrentUser({});
      }
    });
  }

  render() {
    return (
      <div className="Billie-admin-wrapper">
        <Header />
        <div>
          {!this.state.loading ?
            <div>
              {this.props.children}
            </div>
          : <span>Loading</span>
        }
        </div>
      </div>
    );
  }
}

App.contextTypes = {
  router: React.PropTypes.object.isRequired
};

App.propTypes = {
  setCurrentUser: React.PropTypes.func.isRequired
};

export default (connect(null, { setCurrentUser }))(injectIntl(App));
