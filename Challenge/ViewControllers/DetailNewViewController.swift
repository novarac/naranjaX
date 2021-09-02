import UIKit

class DetailNewViewController: BaseViewController {
    
    public var presenter: NewDetailPresenter?
    private lazy var loadingView = UIView(frame: .zero)
    private lazy var indicatorView = UIActivityIndicatorView(frame: .zero)
    private lazy var mainScrollView = UIScrollView(frame: .zero)
    private lazy var mainStackView = UIStackView(frame: .zero)
    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var dateLabel = UILabel(frame: .zero)
    private lazy var headerLabel = UILabel(frame: .zero)
    private lazy var bodyLabel = UILabel(frame: .zero)
    private lazy var image = UIImageView(frame: .zero)
    var currentNew: NewsModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewDetailPresenter(newDetailView: self, newsService: NewsServices())
        presenter?.fetchNewItem(apiURL: currentNew.apiUrl ?? "")
    }
    
    override func addSubviews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(image)
        mainStackView.addArrangedSubview(titleLabel)
        mainStackView.addArrangedSubview(dateLabel)
        mainStackView.addArrangedSubview(headerLabel)
        mainStackView.addArrangedSubview(bodyLabel)
        view.addSubview(loadingView)
        loadingView.addSubview(indicatorView)
    }
    
    override func addStyle() {
        view.backgroundColor = .white
        mainScrollView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        mainStackView.backgroundColor = .white
        
        image.contentMode = . scaleAspectFill
        image.backgroundColor = .white
        
        titleLabel.font = .medium(18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        
        dateLabel.font = .regular(14)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        
        headerLabel.font = .medium(18)
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .black
        
        bodyLabel.font = .regular(14)
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .black
        
        loadingView.backgroundColor = .black.withAlphaComponent(0.2)
        
        indicatorView.color = .white
        indicatorView.style = .medium
    }
    
    override func addConstraints() {
        mainScrollView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollView).inset(0)
            make.bottom.equalTo(mainScrollView).inset(10)
            make.left.right.equalTo(view)
            make.width.equalTo(mainScrollView)
        }
        
        image.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        bodyLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    override func addConfiguration() {
        title = "title_detail_news_item".localized
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.isHidden = true
    }
}

extension DetailNewViewController: NewDetailProtocol {

    func fetchNewItemSuccess(newsItem: NewsModel) {
        titleLabel.text = newsItem.webTitle
        
        if let date = newsItem.webPublicationDate?.getFormattedDate(
            fromFormat: Constants.Date.dateServerFormat,
            toNewFormat: Constants.Date.newsFormat) {
            dateLabel.text = date
            if let date = date.getFormattedToDate(fromFormat: Constants.Date.newsFormat) {
                dateLabel.text = date.timeAgoDisplay()
            }
        } else {
            dateLabel.text = newsItem.webPublicationDate
        }

        headerLabel.text = newsItem.fields?.headline
        if let html = newsItem.fields?.body {
            bodyLabel.attributedText = html.htmlToAttributedString
        } else {
            bodyLabel.text =  newsItem.fields?.bodyText
        }

        if let url = URL(string: newsItem.fields?.thumbnail ?? "") {
            image.kf.setImage(with: url)
            image.clipsToBounds = true
        }
        mainStackView.isHidden = false
    }
    
    func fetchNewItemError() {
        mainStackView.isHidden = true
    }
    
    func showLoader() {
        loadingView.isHidden = false
        indicatorView.startAnimating()
    }
    
    func hideLoader() {
        loadingView.isHidden = true
        indicatorView.stopAnimating()
    }
}
