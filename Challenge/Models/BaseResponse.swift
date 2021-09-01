import Foundation

class BaseResponse: Decodable {
    
    var success: Bool?
    var message: String?
    var code: Int?

    private enum CodingKeys: String, CodingKey {
        case message = "message"
        case code = "code"
        case success = "result"
    }
}
