import Foundation

enum TypeFilterOrderBy: String, CaseIterable {
    case relevance = "filterOrderByRelevance"
    case newest = "filterOrderByNewest"
    case oldest = "filterOrderByOldest"
    
    static let allValues = [relevance, newest, oldest]
}

enum TypeFilterDetailView: String, CaseIterable {
    case present = "filterDetailViewPresent"
    case push = "filterDetailViewPush"
    
    static let allValues = [present, push]
}

enum TypeFilterQuantityItemsByPage: String, CaseIterable {
    case five = "filterQuantityItemsByPageFive"
    case ten = "filterQuantityItemsByPageTen"
    case twenty = "filterQuantityItemsByPageTwenty"
    case fifty = "filterQuantityItemsByPageFifty"
    
    static let allValues = [five, ten, twenty, fifty]
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
