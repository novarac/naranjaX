import Foundation

struct Constants {
    
    static let apiKey = "d335467e-8a9a-42d3-b049-5020762d4a56"
    
    struct Error {
        static let domain = "https://content.guardianapis.com/networking"
        static let defaultMessage = "Unexpected error occurred."
    }
    
    struct Plist {
        static let baseUrlKey = "BaseUrl"
    }
    
    struct Endpoints {
        static let fetchNews = "/search"
    }
    
    struct Date {
        static let dateServerFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let newsFormat = "dd/MM/yyyy"
        static let onlyDate = "dd/MM/yyyy"
    }
}
