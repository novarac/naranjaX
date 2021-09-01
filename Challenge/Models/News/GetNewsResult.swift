import Foundation

class GetNewsResult: Decodable {
    
    var results: [NewsModel]?
    var total: Int
    var startIndex: Int
    var pageSize: Int
    var currentPage: Int = 1
    var pages: Int
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
        case total = "total"
        case startIndex = "startIndex"
        case pageSize = "pageSize"
        case currentPage = "currentPage"
        case pages = "pages"
    }
}
