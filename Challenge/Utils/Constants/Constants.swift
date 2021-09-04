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
        static let pickerDate = "yyyy-MM-dd HH:mm:ss +0000"
    }
    
    struct FiltersDefault {
        static let orderBy = TypeFilterOrderBy.relevance
        static let dateFrom = "01-01-2021"
        static let dateTo = "01-02-2021"
        static let viewDetails = TypeFilterDetailView.push
        static let quantityItemsByPage = TypeFilterQuantityItemsByPage.twenty
        static let quantityCharactersAutoSearch = 3
        static let quantityCharactersAutoSearchMin = 0
        static let quantityCharactersAutoSearchMax = 10
    }
}
