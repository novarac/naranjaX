import Foundation

enum TypeFilterOrderBy: String, CaseIterable {
    case relevance = "filterOrderByRelevance"
    case newest = "filterOrderByNewest"
    case oldest = "filterOrderByOldest"
    
    static let allValues = [relevance, newest, oldest]
    
    var index: Int {
        switch self {
        case .relevance: return 0
        case .newest: return 1
        case .oldest: return 2
        }
    }
}

enum TypeFilterDetailView: String, CaseIterable {
    case present = "filterDetailViewPresent"
    case push = "filterDetailViewPush"
    
    static let allValues = [present, push]
    
    var index: Int {
        switch self {
        case .present: return 0
        case .push: return 1
        }
    }
}

enum TypeFilterQuantityItemsByPage: String, CaseIterable {
    case five = "filterQuantityItemsByPageFive"
    case ten = "filterQuantityItemsByPageTen"
    case twenty = "filterQuantityItemsByPageTwenty"
    case fifty = "filterQuantityItemsByPageFifty"
    
    static let allValues = [five, ten, twenty, fifty]
    
    var index: Int {
        switch self {
        case .five: return 0
        case .ten: return 1
        case .twenty: return 2
        case .fifty: return 3
        }
    }
}

protocol FilterProtocol: AnyObject {
    
}

class FilterPresenter {

    public weak var filterView: FilterProtocol?
    let newsService: NewsServicesProtocol
    var newItem: NewsModel?
    
    init(filterView: FilterProtocol, newsService: NewsServicesProtocol) {
        self.filterView = filterView
        self.newsService = newsService
    }
}
