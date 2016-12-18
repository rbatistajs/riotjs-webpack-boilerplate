
const $xhr = (type, url, data, headers = {}) => {

    headers = Object.assign(
        {'content-type': 'application/json;charset=UTF-8'},
        headers
    )

    let XHR = XMLHttpRequest || ActiveXObject
    let request = new XHR('MSXML2.XMLHTTP.3.0')

    request.open(type, url, true)

    Object.keys(headers).forEach(function(key){
        request.setRequestHeader(key, headers[key])
    })

    return new Promise(function(resolve, reject) {

        request.onreadystatechange = function () {
            let reponse;

            if (request.readyState === 4) {
                reponse = parseRequest(request)

                if (request.status >= 200 && request.status < 300) {
                    resolve(reponse)
                }

                reject(reponse)
            }
        };

    	request.send(JSON.stringify(data))
    })
}

const parseRequest = (request) => {
    let result;

    try {
      result = JSON.parse(request.responseText)
    } catch (e) {
      result = request.responseText;
    }

    return {
        data: result,
        req: request
    }
};

const toQueryString = (obj) => {
    return _.map(obj, (v,k) =>
        encodeURIComponent(k) + '=' + encodeURIComponent(v)
    ).join('&')
};

// GET Request
const $get = (url, params, config = {}) => {
    if (params)
        url += '?' + toQueryString(params)
    return $xhr('GET', url, null, config.headers)
}

// POST Request
const $post = (url, data, config = {}) => {
    if (config.params)
        url += '?' + toQueryString(config.params)

    return $xhr('POST', url, data, config.headers)
}

// DELETE Request
const $delete = (url, params, config = {}) => {
    if (params)
        url += '?' + toQueryString(params)

    return $xhr('DELETE', url, null, config.headers)
}

// PATH Request
const $path = (url, data, config = {}) => {
    if (config.params)
        url += '?' + toQueryString(config.params)

    return $xhr('PUT', url, data, config.headers)
}

// PUT Request
const $put = (url, data, config = {}) => {
    if (config.params)
        url += '?' + toQueryString(config.params)

    return $xhr('PATH', url, data, config.headers)
}

const $http = {
    get: $get,
    post: $post,
    put: $put,
    path: $path,
    'delete': $delete
}

export default $http
export { $http, $xhr, $get, $post, $put, $delete, $path }
