import UIKit

public protocol MainViewProtocol: AnyObject {
    func fetchNewsSuccess(news: [NewsModel])
    func fetchNewsError()
    func hideLoader()
    func showLoader()
}

class MainViewController: BaseViewController {
    
    public var presenter: MainPresenterProtocol?
    private lazy var loadingView = UIView(frame: .zero)
    private lazy var indicatorView = UIActivityIndicatorView(frame: .zero)
    private lazy var mainTableView = UITableView(frame: .zero)
    private lazy var thereAreNotNewsLabel = UILabel(frame: .zero)
    private lazy var thereAreNotNewsImage = UIImageView(frame: .zero)
    
    private var identifier = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MainPresenter(view: self, service: NewsServices())
    }
    
    override func addSubviews() {
        view.addSubview(mainTableView)
        view.addSubview(thereAreNotNewsLabel)
        view.addSubview(thereAreNotNewsImage)
        view.addSubview(loadingView)
        loadingView.addSubview(indicatorView)
    }
    
    override func addStyle() {
        view.backgroundColor = .white

        mainTableView.backgroundColor = .lightGray.withAlphaComponent(0.5)
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
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeArea.top)
            make.bottom.leading.trailing.equalToSuperview()
        }
        
        thereAreNotNewsImage.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
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
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let countItems = presenter?.getNewItemsCount() else { return 0}
        
        if countItems > 0 {
            thereAreNotNewsLabel.isHidden = true
            thereAreNotNewsImage.isHidden = true
        } else {
            thereAreNotNewsLabel.isHidden = false
            thereAreNotNewsImage.isHidden = false
        }
        return countItems
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? NewCellItem
        let newItem = presenter?.getItemByIndex(item: indexPath.row)
        cell?.configure(forNew: newItem)
        let bgColorView = UIView()
        bgColorView.backgroundColor = .secondaryColor.withAlphaComponent(0.5)
        cell?.selectedBackgroundView = bgColorView
        return cell ?? UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
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
        mainTableView.reloadData()
        mainTableView.setContentOffset(.zero, animated: true)
    }
    
    public func fetchNewsError() {
        print("fetchNewsError")
    }
}
