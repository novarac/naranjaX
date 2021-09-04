import Foundation

struct SearchNewFiltersRequest: Codable {
    
    var query: String?
    var startIndex: Int = 1
    var pageSize: Int = 10
    var page: Int = 1
    var format: String?
    var fromDate: String?
    var toDate: String?
    var showTags: String?
    var showFields: String?
    var orderBy: String?
    var tag: String?
    
    enum CodingKeys: String, CodingKey {
        case query = "q"
        case startIndex
        case pageSize = "page-size"
        case page
        case format
        case fromDate = "from-date"
        case toDate = "to-date"
        case showTags = "show-tags"
        case showFields = "show-fields"
        case orderBy = "order-by"
        case tag
    }
}
