import Foundation

class GetNewsResponse: BaseResponse {

    var response: GetNewsResult?
    
    private enum CodingKeys: String, CodingKey {
        case response = "response"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decodeIfPresent(GetNewsResult.self, forKey: .response)
        try super.init(from: decoder)
    }
}
