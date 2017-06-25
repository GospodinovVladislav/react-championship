import defaultRequest from 'rest/interceptor/defaultRequest';
import mime from 'rest/interceptor/mime';
import baseRegistry from 'rest/mime/registry';
import hal from 'rest/mime/type/application/hal';
import rest from 'rest';
import uriTemplateInterceptor from './uriTemplateInterceptor';
import unauthorizedInterceptor from './unauthorizedInterceptor';


let registry = baseRegistry.child();

registry.register('text/uri-list', uriTemplateInterceptor);
registry.register('application/hal+json', hal);

class RestClient {
  constructor(rootPath) {
    this.rels = {};
    this.root = rootPath;
    this.restClient = rest
			.wrap(mime, { registry })
            .wrap(uriTemplateInterceptor)
			.wrap(unauthorizedInterceptor)
			.wrap(defaultRequest, { headers: { Accept: 'application/hal+json' } });
  }

  init() {
    let result = new Promise((resolve) => {
      if (this.rels !== undefined && Object.keys(this.rels).length === 0) {
        this.restClient({
          method: 'GET',
          path: this.root
        }).then(response => {
          const links = response.entity._links;

          for (let key in links) {
            this.rels[key] = links[key].href;
          }
          resolve();
        });
      } else {
        resolve();
      }
    });
    return result;
  }

  exec(params) {
    return this.init().then(() => {
      if (!params.path) {
        if (!params.rel) {
          // eslint-disable-next-line
          throw 'Missing path or rel parameter';
        } else {
          params.path = this.rels[params.rel];
        }
      }
      return this.restClient(params);
    });
  }

  get(params) {
    params.method = 'GET';
    console.log(params);
    return this.exec(params);
  }

  post(params) {
    params.method = 'POST';
    if (params.headers) {
      params.headers['Content-Type'] = 'application/json';
    } else {
      params.headers = { 'Content-Type': 'application/json' };
    }
    return this.exec(params);
  }

  put(params) {
    params.method = 'PUT';
    return this.exec(params);
  }

  patch(params) {
    params.method = 'PATCH';
    return this.exec(params);
  }

  delete(params) {
    params.method = 'DELETE';
    return this.exec(params);
  }
}

module.exports = new RestClient('/api');
