
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import reducers from './reducers/rootReducer';
import ENMessages from '../assets/i18n/en_messages';

export const getTranslateOptions = () => {
  let locale = 'en';
  let messages = ENMessages;
  return { locale, messages };
};

const initialState = {
  intl: getTranslateOptions()
};

/* eslint-disable no-underscore-dangle */
const store = createStore(
  reducers,
  initialState,
  applyMiddleware(thunk)
);
/* eslint-enable */
export default store;
