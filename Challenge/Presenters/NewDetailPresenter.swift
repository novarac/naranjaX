import Foundation

protocol NewDetailProtocol: AnyObject {
    func fetchNewItemSuccess(newsItem: NewsModel)
    func fetchNewItemError()
    func hideLoader()
    func showLoader()
}

class NewDetailPresenter {

    public weak var newDetailView: NewDetailProtocol?
    let newsService: NewsServicesProtocol
    var newItem: NewsModel?
    
    init(newDetailView: NewDetailProtocol, newsService: NewsServicesProtocol) {
        self.newDetailView = newDetailView
        self.newsService = newsService
    }
    
    func fetchNewItem(apiURL: String) {
        newDetailView?.showLoader()
        newsService.fetchNewByURL(url: apiURL) { [weak self] (news, error) in
            guard let weakSelf = self else {
                return
            }

            weakSelf.newDetailView?.hideLoader()

            if let error = error {
                print(error)
                weakSelf.newDetailView?.fetchNewItemError()
            } else {
                guard let newsResult = news?.response?.content else {
                    weakSelf.newDetailView?.fetchNewItemError()
                    return
                }
                weakSelf.newItem = newsResult
                weakSelf.newDetailView?.fetchNewItemSuccess(newsItem: newsResult)
            }
        }
    }
}
