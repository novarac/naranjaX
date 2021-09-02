import Foundation
import Alamofire

protocol NewsServicesProtocol {
    func fetchNews(searchText: String, indexPage: Int, completion: @escaping (_ news: GetNewsResponse?, _ error: Error?) -> Void)
    func fetchNewByURL(url: String, completion: @escaping (_ news: GetNewsItemResponse?, _ error: Error?) -> Void)
}

class NewsServices: NewsServicesProtocol {
    func fetchNews(searchText: String, indexPage: Int = 0, completion: @escaping (GetNewsResponse?, Error?) -> Void) {
//        order-by: relevance, newest, oldest, none
        
        let fieldsString = "starRating,headline,thumbnail,short-url"
        let escapedFieldsString = fieldsString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        
        let parameters = ["q": searchText,
                          "startIndex": 1,
                          "page-size": 10,
                          "page": indexPage,
                          "format": "json",
                          "from-date": "2021-01-01",
//                          "to-date": "",
                          "show-tags": "contributor",
                          "show-fields": escapedFieldsString!,
                          "order-by": "relevance",
                          "tag": "film/film,tone/reviews",
                          "api-key": Constants.apiKey] as [String: Any]
        
        let endpoint = Constants.Endpoints.fetchNews
        APICLient().getEntity(endpoint: endpoint, parameters: parameters) { (incidents, error) in
            completion(incidents, error)
        }
    }
    
    func fetchNewByURL(url: String, completion: @escaping (_ news: GetNewsItemResponse?, _ error: Error?) -> Void) {
        let urlString =  "\(url)?show-fields=all&api-key=\(Constants.apiKey)"

        APICLient().getEntity(url: urlString) { (incidents, error) in
            completion(incidents, error)
        }
    }
}
