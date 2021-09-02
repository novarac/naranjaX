import Foundation

class NewsFieldsModel: Codable {
    
    var headline: String?
    var main: String?
    var body: String?
    var thumbnail: String?
    var bodyText: String?
    var starRating: String?
    
    enum CodingKeys: String, CodingKey {
        case headline = "headline"
        case main = "main"
        case body = "body"
        case thumbnail = "thumbnail"
        case bodyText = "bodyText"
        case starRating = "starRating"
    }
}
