import Foundation

public class NewsModel: NSObject, Decodable {
    
    var webPublicationDate: String?
    var webTitle: String?
    var apiUrl: String?
    var fields: GetNewsFields?
    
    enum CodingKeys: String, CodingKey {
        case webPublicationDate = "webPublicationDate"
        case webTitle = "webTitle"
        case apiUrl = "apiUrl"
        case fields = "fields"
    }
    
    override required convenience init() {
        self.init()
    }
}
