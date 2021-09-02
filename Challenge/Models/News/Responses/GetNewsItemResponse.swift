import Foundation

class GetNewsItemResponse: BaseResponse {

    var response: GetNewsItemContent?
    
    private enum CodingKeys: String, CodingKey {
        case response = "response"
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.response = try container.decodeIfPresent(GetNewsItemContent.self, forKey: .response)
        try super.init(from: decoder)
    }
}
