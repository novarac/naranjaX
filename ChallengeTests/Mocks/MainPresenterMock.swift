import UIKit

@testable import Challenge

public class MainPresenterMock: MainPresenterProtocol {
    public weak var view: MainViewProtocol?
    var service: NewsServicesProtocol?
    private var news: [NewsModel] = []
    
    init(view: MainViewProtocol, service: NewsServicesProtocol? = nil) {
        self.view = view
        self.service = service
        self.fetchNews(searchText: "")
    }
    
    public func fetchNews(searchText: String = "") {
        let item = NewsModel(webPublicationDate: "2021-01-01",
                             webTitle: "title",
                             apiUrl: "",
                             sectionName: "sectionName",
                             fields: nil)
        news.append(item)
    }
    
    public func getNewItemsCount() -> Int {
        return news.count
    }
    
    public func getItemByIndex(item: Int) -> NewsModel? {
        return news[item]
    }
    
    public func fetchNewsResetSearch(searchText: String) {
        
    }
    
    public func fetchNewsMoreItems() {
        
    }
    
    public func showFilterView(viewC: UIViewController) {
        
    }
    
    public func showDetailNewView(viewC: UIViewController, row: Int) {
        
    }
    
    public func getSectionItems(section: Int) -> [NewsModel] {
        return []
    }
    
    public func getSectionsCount() -> Int {
        return 0
    }
    
    public func getSectionItem(index: Int) -> String {
        return "title header"
    }
}
