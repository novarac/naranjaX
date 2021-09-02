import Alamofire

class APICLient {
    
    func getEntity<T: BaseResponse>(
        endpoint: String? = nil,
        url: String? = nil,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
            url: url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            environment: environment)
            .responseDecodable(of: T.self) { (response) in
                APIErrorHandler().validateResponse(response, completion: { (entity, error) in
                    completion(entity, error)
                })
            }
    }
    
    func getIsoLatinEntity<T: BaseResponse>(
        endpoint: String? = nil,
        url: String? = nil,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
            url: url,
            method: .get,
            parameters: parameters,
            encoding: URLEncoding.default,
            environment: environment)
            .responseData { data in
                APIErrorHandler().validateDataResponse(data) { (entity, error) in
                    completion(entity, error)
                }
            }
    }

    func postEntity<T: BaseResponse>(
        endpoint: String? = nil,
        url: String? = nil,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
            url: url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            environment: environment)
            .responseDecodable(of: T.self) { (response) in
                APIErrorHandler().validateResponse(response, completion: { (entity, error) in
                    completion(entity, error)
                })
            }
    }

    func postIsoLatinEntity<T: BaseResponse>(
        endpoint: String? = nil,
        url: String? = nil,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
            url: url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            environment: environment)
            .responseData { data in
                APIErrorHandler().validateDataResponse(data) { (entity, error) in
                    completion(entity, error)
                }
            }
    }

    func putEntity<T: BaseResponse>(
        endpoint: String? = nil,
        url: String? = nil,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {

        createRequest(
            endpoint: endpoint,
            url: url,
            method: .put,
            parameters: parameters,
            encoding: JSONEncoding.default,
            environment: environment)
            .responseDecodable(of: T.self) { (response) in
                APIErrorHandler().validateResponse(response, completion: { (entity, error) in
                    completion(entity, error)
                })
            }
    }

    func getJson<T: Decodable>(
        environment: EnvironmentDelegate,
        endpoint: String? = nil,
        url: String? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {

        createRequest(
            endpoint: endpoint,
            url: url,
            method: .get,
            parameters: nil,
            encoding: CustomURLEncoding(),
            environment: environment)
            .responseDecodable(of: T.self) { (response) in
                completion(response.value, nil)
            }
    }
    
    func createRequest(
        endpoint: String?,
        url: String?,
        method: Alamofire.HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        environment: EnvironmentDelegate? = nil) -> DataRequest {

        var urlString = ""
        if let url = url {
            urlString = url
        }
        if let endpoint = endpoint {
            urlString = APIEnvironment().path(endpoint)
            if let environment = environment {
                urlString = environment.path(endpoint)
            }
        }
        
        var params = parameters ?? [:]

        params["api-key"] = Constants.apiKey
        
//        var headers = HTTPHeaders()
//        if let token = Session.shared.user?.token {
//            headers["Authorization"] = "Bearer \(token)"
//        }

        debugPrint(urlString)
        let request = AF.request(urlString, method: method, parameters: params, encoding: encoding, headers: nil)
            .responseString { response in
                debugPrint("Request: \(response.debugDescription)")
                debugPrint("Response: \(response)")
        }
        
        return request
    }
}
