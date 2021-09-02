import Foundation

public protocol MainPresenterProtocol: AnyObject {
    func fetchNews(searchText: String)
    func fetchNewsResetSearch(searchText: String)
    func fetchNewsMoreItems()
    func getNewItemsCount() -> Int
    func getItemByIndex(item: Int) -> NewsModel?
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
        
        service?.fetchNews(searchText: currSearchText, indexPage: currentPage) { [weak self] (news, error) in
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
}
