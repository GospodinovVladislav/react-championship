import { browserHistory } from 'react-router';
import interceptor from 'rest/interceptor';

export default interceptor({
  response(response) {
    if (response.status.code === 401) {
      browserHistory.push('/login');
    }
    return response;
  }
});
