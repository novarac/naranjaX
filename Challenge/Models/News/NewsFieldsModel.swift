import Foundation

class NewsFieldsModel: Codable {
    
    var headline: String?
    var main: String?
    var body: String?
    var thumbnail: String?
    var bodyText: String?
    var starRating: String?
    
    enum CodingKeys: String, CodingKey {
        case headline
        case main
        case body
        case thumbnail
        case bodyText
        case starRating
    }
}
