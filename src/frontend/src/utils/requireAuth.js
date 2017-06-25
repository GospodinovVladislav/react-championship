import React, { Component } from 'react';
import { connect } from 'react-redux';
import { setCurrentUser } from '../actions/authActions';

export default function (ComposedComponent, requiredRole) {
  class Authenticate extends Component {

    componentWillMount() {
      if (!this.props.auth.isAuthenticated) {
        this.context.router.push('/admin/login');
      }

      const roles = this.props.auth.user.roles;
      if (this.props.auth.isAuthenticated && requiredRole && (!roles || !roles.includes(requiredRole))) {
        this.context.router.push('/admin/login');
      }
    }

    componentWillUpdate(nextProps) {
      if (nextProps.isAuthenticated === false) {
        this.context.push('/');
      }
    }

    render() {
      return (
        <ComposedComponent {...this.props} />
      );
    }
    }

  Authenticate.contextTypes = {
    router: React.PropTypes.object.isRequired
  };

  function mapStateToProps(state) {
    return {
      auth: state.auth,
    };
  }

  Authenticate.propTypes = {
    setCurrentUser: React.PropTypes.func.isRequired
  };


  return connect(mapStateToProps, { setCurrentUser })(Authenticate);
}
