import UIKit

public protocol MainViewProtocol: AnyObject {
    func fetchNewsSuccess(news: [NewsModel])
    func fetchNewsError()
    func hideLoader()
    func showLoader()
}

class MainViewController: BaseViewController {
    
    public var presenter: MainPresenterProtocol?
    private lazy var headerView = UIView(frame: .zero)
    private lazy var searchBarView = UISearchBar(frame: .zero)
    private lazy var loadingView = UIView(frame: .zero)
    private lazy var indicatorView = UIActivityIndicatorView(frame: .zero)
    private lazy var mainTableView = UITableView(frame: .zero)
    private lazy var thereAreNotNewsLabel = UILabel(frame: .zero)
    private lazy var thereAreNotNewsImage = UIImageView(frame: .zero)
    private var refreshControl: UIRefreshControl?
    var isLoadingList = false
    
    private var identifier = "Cell"
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, service: NewsServices())
    }
    
    // MARK: BaseViewController
    
    override func addSubviews() {
        view.addSubview(headerView)
        headerView.addSubview(searchBarView)
        view.addSubview(mainTableView)
        view.addSubview(thereAreNotNewsLabel)
        view.addSubview(thereAreNotNewsImage)
        view.addSubview(loadingView)
        loadingView.addSubview(indicatorView)
    }
    
    override func addStyle() {
        view.backgroundColor = .backgroundSections

        headerView.backgroundColor = .white
        
        searchBarView.tintColor = UIColor.white
        searchBarView.barTintColor = UIColor.white
                
        if let textfield = searchBarView.value(forKey: "searchField") as? UITextField {
            textfield.textColor = UIColor.black
            textfield.backgroundColor = .primaryColor.withAlphaComponent(0.5)
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
        
        mainTableView.backgroundColor = .clear //.lightGray.withAlphaComponent(0.5)
        mainTableView.separatorStyle = .none
        mainTableView.separatorColor = .secondaryColor
        
        thereAreNotNewsImage.contentMode = .scaleAspectFit
        thereAreNotNewsImage.image = CommonAssets.noNews.image.withRenderingMode(.alwaysTemplate)
        thereAreNotNewsImage.tintColor = .gray.withAlphaComponent(0.3)
        
        thereAreNotNewsLabel.font = .medium(14)
        thereAreNotNewsLabel.textColor = .gray.withAlphaComponent(0.3)
        thereAreNotNewsLabel.textAlignment = .center
        
        loadingView.backgroundColor = .black.withAlphaComponent(0.2)
        
        indicatorView.color = .white
        indicatorView.style = .medium
    }
    
    override func addConstraints() {
        headerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        searchBarView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(10)
            make.trailing.equalToSuperview().inset(10)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        thereAreNotNewsImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(60)
        }
        
        thereAreNotNewsLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(thereAreNotNewsImage.snp.bottom).offset(10)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func addConfiguration() {
        title = "title_home".localized
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(NewCellItem.self, forCellReuseIdentifier: identifier)
        mainTableView.rowHeight = 100
        mainTableView.tableFooterView = UIView()
        
        thereAreNotNewsLabel.text = "noNewsToShow".localized
        thereAreNotNewsLabel.isHidden = true
        thereAreNotNewsImage.isHidden = true
        
        setRefreshControl()
        
        searchBarView.delegate = self
        searchBarView.placeholder = "seach".localized
    }
    
    // MARK: Public Methods
    
    // MARK: UITableView Pull Refresh
    func setRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.attributedTitle = NSAttributedString(string: "↓ Actualizar ↓")
        refreshControl!.addTarget(self, action: #selector(refresh), for: .valueChanged)
        mainTableView.addSubview(refreshControl!)
    }
    
    @objc func refresh() {
        presenter?.fetchNewsResetSearch(searchText: searchBarView.text ?? "")
    }
    
    // MARK: UITableView scrolldown to view more items
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBarView.resignFirstResponder()
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList) {
            if presenter?.getNewItemsCount() ?? 0 > 0 {
                isLoadingList = true
                loadMoreItemsForList()
            }
        }
    }
    
    func loadMoreItemsForList() {
        presenter?.fetchNewsMoreItems()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countItems = presenter?.getNewItemsCount() else { return 0}
        
        if countItems > 0 {
            thereAreNotNewsLabel.isHidden = true
            thereAreNotNewsImage.isHidden = true
            mainTableView.isHidden = false
        } else {
            thereAreNotNewsLabel.isHidden = false
            thereAreNotNewsImage.isHidden = false
            mainTableView.isHidden = true
        }
        return countItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewCellItem
        let newItem = presenter?.getItemByIndex(item: indexPath.row)
        cell?.configure(forNew: newItem)
        let bgColorView = UIView()
        bgColorView.backgroundColor = .primaryColor.withAlphaComponent(0.5)
        cell?.selectedBackgroundView = bgColorView
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarView.resignFirstResponder()
        let newItem = presenter?.getItemByIndex(item: indexPath.row)
        let vcDetail = DetailNewViewController()
        vcDetail.currentNew = newItem
//        present(vcDetail, animated: true, completion: nil)
        navigationController?.pushViewController(vcDetail, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: MainViewProtocol {
    
    public func showLoader() {
        loadingView.isHidden = false
        indicatorView.startAnimating()
    }
    
    public func hideLoader() {
        loadingView.isHidden = true
        indicatorView.stopAnimating()
    }
    
    public func fetchNewsSuccess(news: [NewsModel]) {
        if refreshControl != nil {
            refreshControl!.endRefreshing()
        }
        isLoadingList = false
        mainTableView.reloadData()
        mainTableView.setContentOffset(.zero, animated: false)
    }
    
    public func fetchNewsError() {
        print("fetchNewsError")
    }
}

extension MainViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            presenter?.fetchNewsResetSearch(searchText: "")
            return
        }
        if searchBar.text?.count ?? 0 > 3 {
            presenter?.fetchNewsResetSearch(searchText: searchText)
        }
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchNews(searchText: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}
