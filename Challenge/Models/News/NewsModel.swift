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
    
    init(webPublicationDate: String?, webTitle: String?, apiUrl: String?, sectionName: String?, fields: NewsFieldsModel?) {
        self.webPublicationDate = webPublicationDate
        self.webTitle = webTitle
        self.apiUrl = apiUrl
        self.sectionName = sectionName
        self.fields = fields
    }
    
    func description() -> String {
        return "\(String(describing: webPublicationDate))"
    }
}
