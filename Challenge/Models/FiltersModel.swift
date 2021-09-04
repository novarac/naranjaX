import Foundation

public class FilterModel: Codable {
    
    var orderBy: Int
    var dateFrom: String
    var dateTo: String
    var viewDetails: Int
    var quantityItemsByPage: Int
    var quantityCharactersAutoSearch: Int
    
    init(orderBy: Int, dateFrom: String, dateTo: String, viewDetails: Int, quantityItemsByPage: Int, quantityCharactersAutoSearch: Int) {
        self.orderBy = orderBy
        self.dateFrom = dateFrom
        self.dateTo = dateTo
        self.viewDetails = viewDetails
        self.quantityItemsByPage = quantityItemsByPage
        self.quantityCharactersAutoSearch = quantityCharactersAutoSearch
    }
    
    enum CodingKeys: String, CodingKey {
        case orderBy
        case dateFrom
        case dateTo
        case viewDetails
        case quantityItemsByPage
        case quantityCharactersAutoSearch
    }
}
