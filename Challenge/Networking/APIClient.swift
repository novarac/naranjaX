import Alamofire

class APICLient {
    
    func getEntity<T: BaseResponse>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
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
    
    func getEntity<T: BaseResponse>(
        url: String,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            url: url,
            method: .get,
            encoding: URLEncoding.default)
            .responseDecodable(of: T.self) { (response) in
                APIErrorHandler().validateResponse(response, completion: { (entity, error) in
                    completion(entity, error)
                })
            }
    }
    
    func getIsoLatinEntity<T: BaseResponse>(
        endpoint: String,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
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
        endpoint: String,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
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
        endpoint: String,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {
        createRequest(
            endpoint: endpoint,
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
        endpoint: String,
        parameters: [String: Any]? = nil,
        environment: EnvironmentDelegate? = nil,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {

        createRequest(
            endpoint: endpoint,
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
        endpoint: String,
        completion:@escaping (_ entity: T?, _ error: Error?) -> Void) {

        createRequest(
            endpoint: endpoint,
            method: .get,
            parameters: nil,
            encoding: CustomURLEncoding(),
            environment: environment)
            .responseDecodable(of: T.self) { (response) in
                completion(response.value, nil)
            }
    }
    
    func createRequest(
        endpoint: String,
        method: Alamofire.HTTPMethod,
        parameters: [String: Any]?,
        encoding: ParameterEncoding,
        environment: EnvironmentDelegate? = nil) -> DataRequest {

        var urlString = APIEnvironment().path(endpoint)
        if let environment = environment {
            urlString = environment.path(endpoint)
        }
        
        let params = parameters ?? [:]

        var headers = HTTPHeaders()

//        if let token = Session.shared.user?.token {
//            headers["Authorization"] = "Bearer \(token)"
//        }

        debugPrint(urlString)
        let request = AF.request(urlString, method: method, parameters: params, encoding: encoding, headers: headers)
            .responseString { response in
                debugPrint("Request: \(response.debugDescription)")
                debugPrint("Response: \(response)")
        }
        
        return request
    }
    
    func createRequest(
        url: String,
        method: Alamofire.HTTPMethod,
        encoding: ParameterEncoding) -> DataRequest {

        let urlString = url
        let headers = HTTPHeaders()

//        if let token = Session.shared.user?.token {
//            headers["Authorization"] = "Bearer \(token)"
//        }

        debugPrint(urlString)
        let request = AF.request(urlString, method: method, parameters: nil, encoding: encoding, headers: headers)
            .responseString { response in
                debugPrint("Request: \(response.debugDescription)")
                debugPrint("Response: \(response)")
        }
        
        return request
    }
}
