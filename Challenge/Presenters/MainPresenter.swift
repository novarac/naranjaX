import UIKit

public protocol MainPresenterProtocol: AnyObject {
    func fetchNews(searchText: String)
    func fetchNewsResetSearch(searchText: String)
    func fetchNewsMoreItems()
    func getNewItemsCount() -> Int
    func getItemByIndex(item: Int) -> NewsModel?
    func showFilterView(viewC: UIViewController)
    func showDetailNewView(viewC: UIViewController, row: Int)
}

public class MainPresenter: MainPresenterProtocol {

    public weak var view: MainViewProtocol?
    var service: NewsServicesProtocol?
    public var news: [NewsModel] = []
    private var currentPage: Int = 1
    var currSearchText: String = ""
    private var filteredNews: [NewsModel] = []
    
    init(view: MainViewProtocol, service: NewsServicesProtocol? = nil) {
        self.view = view
        self.service = service
        self.fetchNews(searchText: "")
    }
    
    public func fetchNews(searchText: String = "") {
        view?.showLoader()
        if currentPage == 1 || currSearchText != searchText {
            news = []
            currentPage = 1
            currSearchText = searchText
        }
        
        let fieldsString = "starRating,headline,thumbnail,short-url"
        let escapedFieldsString = fieldsString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let filters = ManagerFilters().loadFilters()
        let filterOrderBy = TypeFilterOrderBy.allValues[filters!.orderBy]
        var filterQuantityItemsByPage = 0
        
        switch TypeFilterQuantityItemsByPage.allValues[filters?.quantityItemsByPage ?? 0] as? TypeFilterQuantityItemsByPage {
        case .five:
            filterQuantityItemsByPage = 5
        case .ten:
            filterQuantityItemsByPage = 10
        case .twenty:
            filterQuantityItemsByPage = 20
        case .fifty:
            filterQuantityItemsByPage = 50
        case .none:
            filterQuantityItemsByPage = 5
        }
        
        let searchNewFiltersParams = SearchNewFiltersRequest(query: currSearchText,
                                                       startIndex: 1,
                                                       pageSize: filterQuantityItemsByPage,
                                                       page: currentPage,
                                                       format: "json",
                                                       fromDate: filters?.dateFrom,
                                                       toDate: filters?.dateTo,
                                                       showTags: "contributor",
                                                       showFields: escapedFieldsString,
                                                       orderBy: "\(filterOrderBy)",
                                                       tag: "film/film,tone/reviews")
        
        service?.fetchNews(params: searchNewFiltersParams) { [weak self] (news, error) in
            guard let weakSelf = self else {
                return
            }

            weakSelf.view?.hideLoader()
            if let error = error {
                print(error)
                weakSelf.view?.fetchNewsError()
            } else {
                guard let newsResult = news?.response?.results else {
                    weakSelf.view?.fetchNewsError()
                    return
                }
                weakSelf.currentPage += 1
                weakSelf.news += newsResult
                weakSelf.view?.fetchNewsSuccess(news: newsResult)
            }
        }
    }
    
    public func fetchNewsResetSearch(searchText: String) {
        currentPage = 1
        fetchNews(searchText: searchText)
    }
    
    public func fetchNewsMoreItems() {
        fetchNews(searchText: currSearchText)
    }
    
    public func getNewItemsCount() -> Int {
        return news.count
    }
    
    public func getItemByIndex(item: Int) -> NewsModel? {
        if news.isEmpty { return nil }
        return news[item]
    }
    
    public func getNews() -> [NewsModel] {
        return news
    }
    
    public func showFilterView(viewC: UIViewController) {
        let vcFilter = FilterViewController()
        viewC.present(vcFilter, animated: true, completion: nil)
    }
    
    public func showDetailNewView(viewC: UIViewController, row: Int) {
        let vcDetail = DetailNewViewController()
        vcDetail.currentNew = getItemByIndex(item: row)
        
        let filters = ManagerFilters().loadFilters()
        if let filterViewDetail = filters?.viewDetails {
            if TypeFilterDetailView.present == TypeFilterDetailView.allValues[filterViewDetail] {
                viewC.present(vcDetail, animated: true, completion: nil)
            } else {
                viewC.navigationController?.pushViewController(vcDetail, animated: true)
            }
        } else {
            viewC.present(vcDetail, animated: true, completion: nil)
        }
    }
}
