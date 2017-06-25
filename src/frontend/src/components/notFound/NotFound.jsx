import React from 'react';

/**
 * 404 page not found body component serves to visualize the body of the 404 page not found page
 */
export default class NotFound extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      isAuthenticated: false,
      pageStyle: {
        height: `${window.innerHeight}px`
      }
    };
    this.handleResize = this.handleResize.bind(this);
  }

  componentDidMount() {
    window.addEventListener('resize', this.handleResize);
  }

  handleResize(e) {
    this.setState({
      pageStyle: {
        height: `${window.innerHeight}px`
      }
    });
  }

  componentWillUnmount() {
    window.removeEventListener('resize', this.handleResize);
  }

  render() {
    return (
      <article id="errorPage" className="content-wrap animated fadeIn">
        <div id="small-header" className="small-header" style={this.state.pageStyle}>
          <div id="error-wrapper">
            <div className="error-type text-xs-center">404</div>
            <div className="error-message">
              <span>Page not found</span>
            </div>
          </div>
        </div>
      </article>
    );
  }
}

NotFound.propTypes = {
};
