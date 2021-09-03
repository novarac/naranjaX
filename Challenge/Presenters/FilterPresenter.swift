import Foundation

enum TypeFilterOrderBy: String {
    case newest = "filterOrderByNewest"
    case oldest = "filterOrderByOldest"
    case relevance = "filterOrderByRelevance"
    case none = "filterOrderByNone"
}

enum TypeFilterDetailView: String {
    case present = "filterDetailViewPresent"
    case push = "filterDetailViewPush"
}

enum TypeFilterQuantityItemsByPage: String {
    case ten = "filterQuantityItemsByPageTen"
    case twenty = "filterQuantityItemsByPageTwenty"
    case fifty = "filterQuantityItemsByPageFifty"
    
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
