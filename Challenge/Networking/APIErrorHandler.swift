import Foundation
import Alamofire

class APIErrorHandler {
    
    func validateResponse<T: BaseResponse>(_ response: AFDataResponse<T>, completion:(_ entity: T?, _ error: Error?) -> Void) {
        if let entity = response.value {
                completion(entity, nil)
        } else {
            let error = NSError(
                domain: Constants.Error.domain,
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: Constants.Error.defaultMessage])
            
            completion(nil, error as Error)
        }
    }
    
    func validateDataResponse<T: BaseResponse>(_ response: AFDataResponse<Data>, completion:(_ entity: T?, _ error: Error?) -> Void) {
        if let data = response.data {
            let isoLatin1Data = String(data: data, encoding: .isoLatin1)
            if let utf8Data = isoLatin1Data?.data(using: .utf8) {
                let decoder = JSONDecoder()
                do {
                    let entity = try decoder.decode(T.self, from: utf8Data)
                    if let code = entity.code {
                        // Add any particular code number here, like 403 to force the login again
                        switch code {
                        case 0:
                            completion(entity, nil)
                        default:
                            let error = NSError(
                                domain: Constants.Error.domain,
                                code: code,
                                userInfo: [NSLocalizedDescriptionKey: entity.message ?? Constants.Error.defaultMessage])
                            
                            completion(nil, error as Error)
                        }
                    }
                } catch {
                    let error = NSError(
                        domain: Constants.Error.domain,
                        code: -1,
                        userInfo: [NSLocalizedDescriptionKey: Constants.Error.defaultMessage])
                    
                    completion(nil, error as Error)
                }
            }
        } else {
            let error = NSError(
                domain: Constants.Error.domain,
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: Constants.Error.defaultMessage])
            
            completion(nil, error as Error)
        }
    }
}
