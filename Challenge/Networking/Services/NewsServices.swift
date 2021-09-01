import Foundation
import Alamofire

protocol NewsServicesProtocol {
    func fetchNews(searchText: String, indexPage: Int, completion: @escaping (_ news: GetNewsResponse?, _ error: Error?) -> Void)
}

class NewsServices: NewsServicesProtocol {
    func fetchNews(searchText: String, indexPage: Int = 0, completion: @escaping (GetNewsResponse?, Error?) -> Void) {
//        order-by: relevance, newest, oldest, none
        
        let parameters = ["q": searchText,
                          "startIndex": 1,
                          "page-size": 10,
                          "page": indexPage,
                          "format": "json",
                          "from-date": "2021-01-01",
//                          "to-date": "",
                          "show-tags": "contributor",
                          "show-fields": "starRating,headline,thumbnail,short-url",
                          "order-by": "relevance",
                          "api-key": Constants.apiKey] as [String: Any]

        let endpoint = Constants.Endpoints.fetchNews
        APICLient().getEntity(endpoint: endpoint, parameters: parameters) { (incidents, error) in
            completion(incidents, error)
        }
    }
}
