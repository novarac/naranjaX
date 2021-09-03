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
    private lazy var filterButton = UIButton(frame: .zero)
    private lazy var loadingView = UIView(frame: .zero)
    private lazy var indicatorView = UIActivityIndicatorView(frame: .zero)
    private lazy var mainTableView = UITableView(frame: .zero)
    private lazy var thereAreNotNewsLabel = UILabel(frame: .zero)
    private lazy var thereAreNotNewsImage = UIImageView(frame: .zero)
    private lazy var splashScreenView = SplashScreenView(frame: .zero)
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
        headerView.addSubview(filterButton)
        view.addSubview(mainTableView)
        view.addSubview(thereAreNotNewsLabel)
        view.addSubview(thereAreNotNewsImage)
        view.addSubview(loadingView)
        loadingView.addSubview(indicatorView)
    }
    
    override func addStyle() {
        view.backgroundColor = .backgroundSections

        headerView.backgroundColor = .backgroundCells
        searchBarView.barTintColor = .backgroundCells
        if let textfield = searchBarView.value(forKey: "searchField") as? UITextField {
            textfield.textColor = .fontSeachBarTextField
            textfield.backgroundColor = .backgroundSeachBarTextField
        }
        
        filterButton.setImage(CommonAssets.filter.image.withRenderingMode(.alwaysTemplate), for: .normal)
        filterButton.tintColor = .fontSeachBarTextField
        
        mainTableView.backgroundColor = .clear
        mainTableView.separatorStyle = .none
        
        thereAreNotNewsImage.contentMode = .scaleAspectFit
        thereAreNotNewsImage.image = CommonAssets.noNews.image.withRenderingMode(.alwaysTemplate)
        thereAreNotNewsImage.tintColor = .gray.withAlphaComponent(0.3)
        
        thereAreNotNewsLabel.font = .medium(14)
        thereAreNotNewsLabel.textColor = .gray.withAlphaComponent(0.3)
        thereAreNotNewsLabel.textAlignment = .center
        
        loadingView.backgroundColor = .black.withAlphaComponent(0.2)
        
        indicatorView.color = .primaryColor
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
            make.trailing.equalToSuperview().inset(60)
        }
        
        filterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.height.equalTo(25)
        }
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        thereAreNotNewsImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
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
        let logoTitleView = UIImageView(image: CommonAssets.naranjaXlogoNavBar.image)
        navigationItem.titleView = logoTitleView
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        mainTableView.register(NewCellItem.self, forCellReuseIdentifier: identifier)
        mainTableView.rowHeight = 150
        mainTableView.tableFooterView = UIView()
        
        thereAreNotNewsLabel.text = "noNewsToShow".localized
        
        searchBarView.delegate = self
        searchBarView.placeholder = "placeholderSeach".localized
        
        filterButton.addTarget(self, action: #selector(pressButtonFilter), for: .touchUpInside)
        
        setRefreshControl()
        
        showScreenApp()
    }
    
    // MARK: Public Methods
    
    func showScreenApp() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didBecomeActiveNotification),
                                               name: UIApplication.didBecomeActiveNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(willResignActiveNotification),
                                               name: UIApplication.willResignActiveNotification,
                                               object: nil)
    }
    
    @objc func didBecomeActiveNotification() {
        splashScreenView.removeFromSuperview()
    }
        
    @objc func willResignActiveNotification() {
        getTopMostViewController()?.view.addSubview(splashScreenView)
        splashScreenView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    @objc func pressButtonFilter() {
        presenter?.showFilterView(viewC: self)
    }
    
    // MARK: UITableView Pull Refresh
    func setRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl!.backgroundColor = .clear
        refreshControl!.tintColor = .primaryColor
        let attributesFontColor = [NSAttributedString.Key.foregroundColor: UIColor.primaryColor]
        refreshControl!.attributedTitle = NSAttributedString(string: "↓ Actualizar ↓", attributes: attributesFontColor)
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
                presenter?.fetchNewsMoreItems()
            }
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countItems = presenter?.getNewItemsCount() else { return 0 }
        
        thereAreNotNewsLabel.isHidden = countItems > 0 ? true : false
        thereAreNotNewsImage.isHidden = countItems > 0 ? true : false
        mainTableView.isHidden = countItems > 0 ? false : true
        
        return countItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewCellItem
        cell?.configure(forNew: presenter?.getItemByIndex(item: indexPath.row))
        cell?.backgroundColor = indexPath.row % 2 == 0 ? .backgroundCells : .white
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarView.resignFirstResponder()
        presenter?.showDetailNewView(viewC: self, row: indexPath.row)
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
        if let refreshControl = refreshControl {
            refreshControl.endRefreshing()
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
