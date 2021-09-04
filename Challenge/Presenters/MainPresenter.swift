import UIKit

public protocol MainPresenterProtocol: AnyObject {
    func fetchNews(query: String)
    func fetchNewsResetSearch(query: String)
    func fetchNewsMoreItems()
    func getNewItemsCount() -> Int
    func getItemByIndex(item: Int) -> NewsModel?
    func showFilterView(viewC: UIViewController)
    func showDetailNewView(viewC: UIViewController, new: NewsModel)
    func getSectionItems(section: Int) -> [NewsModel]
    func getSectionsCount() -> Int
    func getSectionItem(index: Int) -> String
}

public class MainPresenter: MainPresenterProtocol {

    public weak var view: MainViewProtocol?
    var service: NewsServicesProtocol?
    public var news: [NewsModel] = []
    private var currentPage: Int = 1
    var currSearchText: String = ""
    var sections: [String] = []
    var sortedSections: [String] = []
    var sectionItems: [NewsModel] = []
    
    init(view: MainViewProtocol, service: NewsServicesProtocol? = nil) {
        self.view = view
        self.service = service
        self.fetchNews(query: "")
    }
    
    public func fetchNews(query: String = "") {
        let searchNewFilterRequest = addSearchNewFiltersParams(query: query)
        fetchNewsWithRequest(searchNewFiltersParams: searchNewFilterRequest)
    }
    
    func fetchNewsWithRequest(searchNewFiltersParams: SearchNewFiltersRequest) {
        view?.showLoader()
        if currentPage == 1 || currSearchText != searchNewFiltersParams.query {
            currentPage = 1
            currSearchText = searchNewFiltersParams.query ?? ""
        }
        
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
                if weakSelf.currentPage == 1 {
                    weakSelf.news = newsResult
                } else {
                    weakSelf.news += newsResult
                }
                weakSelf.currentPage += 1
                weakSelf.sortNewByDate {
                    weakSelf.view?.fetchNewsSuccess(news: newsResult)
                }
            }
        }
    }
    
    func addSearchNewFiltersParams(query: String) -> SearchNewFiltersRequest {
        let fieldsString = "starRating,headline,thumbnail,short-url"
        let escapedFieldsString = fieldsString.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let filters = ManagerFilters().loadFilters()
        let filterOrderBy = TypeFilterOrderBy.allValues[filters!.orderBy]
        var filterQuantityItemsByPage = 0

        switch TypeFilterQuantityItemsByPage.allValues[filters?.quantityItemsByPage ?? 0] {
        case .five:
            filterQuantityItemsByPage = 5
        case .ten:
            filterQuantityItemsByPage = 10
        case .twenty:
            filterQuantityItemsByPage = 20
        case .fifty:
            filterQuantityItemsByPage = 50
        }

        return SearchNewFiltersRequest(query: query,
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

    }
    
    public func fetchNewsResetSearch(query: String) {
        currentPage = 1
        fetchNews(query: query)
    }
    
    public func fetchNewsMoreItems() {
        fetchNews(query: currSearchText)
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
    
    public func showDetailNewView(viewC: UIViewController, new: NewsModel) {
        let vcDetail = DetailNewViewController()
        vcDetail.currentNew = new
        let filters = ManagerFilters().loadFilters()
        if let filterViewDetail = filters?.viewDetails {
            if TypeFilterDetailView.present.index == filterViewDetail {
                viewC.present(vcDetail, animated: true, completion: nil)
            } else {
                viewC.navigationController?.pushViewController(vcDetail, animated: true)
            }
        } else {
            viewC.present(vcDetail, animated: true, completion: nil)
        }
    }
    
    func sortNewByDate(completion: () -> Void) {
        sections = [String]()
        sortedSections = [String]()
        let filtersSaved = ManagerFilters().loadFilters()
        if filtersSaved?.orderBy == TypeFilterOrderBy.relevance.index {
            sortedSections = [""]
            completion()
            return
        }
        for new in news {
            let sorteByString = new.webPublicationDate?.getFormattedDate(fromFormat: Constants.Date.dateServerFormat,
                                                                                  toNewFormat: Constants.Date.newsFormat) ?? ""
            if !sections.contains(sorteByString) {
                sections.append(sorteByString)
            }
        }
        if filtersSaved?.orderBy == TypeFilterOrderBy.newest.index {
            sortedSections = sections.sorted(by: >)
        } else {
            sortedSections = sections.sorted(by: <)
        }
        completion()
    }
    
    public func getSectionItems(section: Int) -> [NewsModel] {
        var sectionItems = [NewsModel]()
        let filtersSaved = ManagerFilters().loadFilters()
        if filtersSaved?.orderBy == 0 {
            sectionItems = news
            return sectionItems
        }
        for item in news {
            let newItem = item as NewsModel
            let sorteByString = item.webPublicationDate?.getFormattedDate(fromFormat: Constants.Date.dateServerFormat,
                                                                                  toNewFormat: Constants.Date.newsFormat) ?? ""
            if sorteByString == sections[section] {
                sectionItems.append(newItem)
            }
        }
        return sectionItems
    }
    
    public func getSectionsCount() -> Int {
        return sortedSections.count
    }
    
    public func getSectionItem(index: Int) -> String {
        return sortedSections[index]
    }
}
