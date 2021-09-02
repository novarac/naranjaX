import Foundation

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
