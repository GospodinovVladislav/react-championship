const client = require('rest');

export default function jwt({ dispatch, getState }) {
  return (next) => (action) => {
    let result = new Promise((resolve, reject) => {
            // only worry about expiring token for async actions
      if (typeof action === 'function') {
        if (getState().auth && getState().auth.user) {
          const auth = getState().auth.user;
          const tokenExpiration = auth.exp;

          if (tokenExpiration && tokenExpiration < new Date().getTime() / 1000) {
            client({
              path: '/api/refresh',
              method: 'POST',
              headers: {
                Accept: 'application/json',
                'Content-Type': 'application/json'
              },
              entity: JSON.stringify({ token: auth.refresh_token })
            }).then(data => {
              resolve(next(action));
            });
          } else {
            resolve(next(action));
          }
        } else {
          resolve(next(action));
        }
      } else {
        resolve(next(action));
      }
    });
    return result;
  };
}
