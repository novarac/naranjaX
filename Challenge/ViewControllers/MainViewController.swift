import UIKit

public protocol MainViewProtocol: AnyObject {
    func fetchNewsSuccess(news: [NewsModel])
    func fetchNewsError(messageError: String)
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
    private var toastMessageView: ToastMessageView!
    private var timerToast: Timer!
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
        view.addSubview(thereAreNotNewsLabel)
        view.addSubview(thereAreNotNewsImage)
        view.addSubview(mainTableView)
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSearch), name: Notification.Name("refreshSearch"), object: nil)
        
        configureToastMessageView()
    }
    
    // MARK: Public Methods
    
    @objc func refreshSearch() {
        refreshPullToDown()
    }
    
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
        refreshControl!.attributedTitle = NSAttributedString(string: "updatePullToDown".localized, attributes: attributesFontColor)
        refreshControl!.addTarget(self, action: #selector(refreshPullToDown), for: .valueChanged)
        mainTableView.addSubview(refreshControl!)
    }
    
    @objc func refreshPullToDown() {
        presenter?.fetchNewsResetSearch(query: searchBarView.text ?? "")
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
    
    // MARK: Toast message
    func configureToastMessageView() {
        toastMessageView = ToastMessageView(frame: .zero)
        if let topController = getTopMostViewController() {
            topController.view.addSubview(toastMessageView)
            toastMessageView.snp.makeConstraints({ make in
                make.bottom.equalToSuperview()
                make.height.equalTo(60)
                make.leading.trailing.equalToSuperview()
            })
            toastMessageView.alpha = 0
            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(showToastMessage),
                                                   name: Notification.Name("showToastMessage"),
                                                   object: nil)
        }
    }
    
    @objc func showToastMessage(notif: Notification) {
        if let topController = getTopMostViewController() {
            topController.view.bringSubviewToFront(toastMessageView)
            toastMessageView.showMessage(message: notif.object as? String ?? "")
            UIView.animate(withDuration: 0.2) {
                self.toastMessageView.alpha = 1
            }
            timerToast = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerToastFinish), userInfo: nil, repeats: false)
        }
    }
    
    @objc func timerToastFinish() {
        timerToast.invalidate()
        UIView.animate(withDuration: 0.2) {
            self.toastMessageView.alpha = 0
        }
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.getSectionsCount() ?? 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let countItems = presenter?.getSectionItems(section: section).count ?? 0
        thereAreNotNewsLabel.isHidden = countItems > 0 ? true : false
        thereAreNotNewsImage.isHidden = countItems > 0 ? true : false
        mainTableView.isHidden = countItems > 0 ? false : true
        return countItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewCellItem
        let sectionItems = presenter?.getSectionItems(section: indexPath.section)
        cell?.configure(forNew: sectionItems?[indexPath.row])
        cell?.backgroundColor = indexPath.row % 2 == 0 ? .backgroundCells : .white
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBarView.resignFirstResponder()
        let sectionItems = presenter?.getSectionItems(section: indexPath.section)
        if let newModel = sectionItems?[indexPath.row] {
            presenter?.showDetailNewView(viewC: self, new: newModel)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let filtersSaved = ManagerFilters().loadFilters()
        return filtersSaved?.orderBy == TypeFilterOrderBy.relevance.index ? 0.0 : 30.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        
        let bgView = UIView(frame: .zero)
        headerView.addSubview(bgView)
        bgView.backgroundColor = .primaryColor.withAlphaComponent(0.75)
        bgView.layer.cornerRadius = 15
        bgView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.bottom.equalToSuperview()
            make.width.equalTo(160)
        }
        
        let titleLabel = UILabel(frame: .zero)
        bgView.addSubview(titleLabel)
        titleLabel.font = .medium(18)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .white
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        titleLabel.text = presenter?.getSectionItem(index: section)
        
        return headerView
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
    
    public func fetchNewsError(messageError: String) {
        let alert = UIAlertController(title: "title_error".localized, message: "message_error".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "try_again_button".localized, style: .default, handler: { _ in
            
        }))
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.isEmpty {
            presenter?.fetchNewsResetSearch(query: "")
            return
        }
        let filters = ManagerFilters().loadFilters()
        let filtersQuantityCharactersAutoSearch = filters?.quantityCharactersAutoSearch ?? Constants.FiltersDefault.quantityCharactersAutoSearch
        if filtersQuantityCharactersAutoSearch == 0 {
            return
        }
        if searchBar.text?.count ?? 0 >= filtersQuantityCharactersAutoSearch {
            presenter?.fetchNewsResetSearch(query: searchText)
        }
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        let filters = ManagerFilters().loadFilters()
        let filtersQuantityCharactersAutoSearch = filters?.quantityCharactersAutoSearch ?? Constants.FiltersDefault.quantityCharactersAutoSearch
        searchBar.returnKeyType = filtersQuantityCharactersAutoSearch == 0 ? .done : .search
        return true
    }
    
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter?.fetchNews(query: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
}
