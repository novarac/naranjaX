import Foundation

public class NewsModel: NSObject, Decodable {
    
    var webPublicationDate: String?
    var webTitle: String?
    var apiUrl: String?
    var sectionName: String?
    var fields: NewsFieldsModel?
    
    enum CodingKeys: String, CodingKey {
        case webPublicationDate
        case webTitle
        case apiUrl
        case sectionName
        case fields
    }
    
    override required convenience init() {
        self.init()
    }
}
