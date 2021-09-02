import Foundation

public class NewsModel: NSObject, Decodable {
    
    var webPublicationDate: String?
    var webTitle: String?
    var apiUrl: String?
    var sectionName: String?
    var fields: NewsFieldsModel?
    
    enum CodingKeys: String, CodingKey {
        case webPublicationDate = "webPublicationDate"
        case webTitle = "webTitle"
        case apiUrl = "apiUrl"
        case sectionName = "sectionName"
        case fields = "fields"
    }
    
    override required convenience init() {
        self.init()
    }
}
