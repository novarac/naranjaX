import Foundation
import Alamofire

protocol NewsServicesProtocol {
    func fetchNews(params: SearchNewFiltersRequest, completion: @escaping (_ news: GetNewsResponse?, _ error: Error?) -> Void)
    func fetchNewByURL(url: String, params: SearchNewFiltersRequest, completion: @escaping (_ news: GetNewsItemResponse?, _ error: Error?) -> Void)
}

class NewsServices: NewsServicesProtocol {
    func fetchNews(params: SearchNewFiltersRequest, completion: @escaping (GetNewsResponse?, Error?) -> Void) {
        
        let parameters = params.dictionary
        
        let endpoint = Constants.Endpoints.fetchNews
        APICLient().getEntity(endpoint: endpoint, parameters: parameters) { (incidents, error) in
            completion(incidents, error)
        }
    }
    
    func fetchNewByURL(url: String, params: SearchNewFiltersRequest, completion: @escaping (_ news: GetNewsItemResponse?, _ error: Error?) -> Void) {
        
        let parameters = params.dictionary

        APICLient().getEntity(url: url, parameters: parameters) { (incidents, error) in
            completion(incidents, error)
        }
    }
}
