import Foundation

class GetNewsItemContent: Decodable {
    
    var content: NewsModel?
    
    enum CodingKeys: String, CodingKey {
        case content
    }
}
