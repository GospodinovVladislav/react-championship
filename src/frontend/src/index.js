import React from 'react';
import ReactDOM from 'react-dom';
import en from 'react-intl/locale-data/en';
import { Router, Route, browserHistory } from 'react-router';
import { Provider } from 'react-intl-redux';
import { addLocaleData } from 'react-intl';
import App from './App';
import Home from './components/home/Home.jsx';
import store from './store';
import NotFound from './components/notFound/NotFound.jsx';

addLocaleData([...en]);

ReactDOM.render(
  <Provider store={store}>
    <Router history={browserHistory}>
      <Route path="/championship" component={App}>
        <Route path="/home" component={Home} />
        <Route path="*" component={NotFound} />
      </Route>
    </Router>
  </Provider>,
    document.getElementById('root')
);
