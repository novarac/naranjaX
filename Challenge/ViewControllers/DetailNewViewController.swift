import UIKit

class DetailNewViewController: BaseViewController {
    
    public var presenter: NewDetailPresenter?
    private lazy var loadingView = UIView(frame: .zero)
    private lazy var closeButton = UIButton(frame: .zero)
    private lazy var indicatorView = UIActivityIndicatorView(frame: .zero)
    private lazy var mainScrollView = UIScrollView(frame: .zero)
    private lazy var mainStackView = UIStackView(frame: .zero)
    private lazy var maskView = UIView(frame: .zero)
    private lazy var contentFieldsStackView = UIStackView(frame: .zero)
    private lazy var titleLabel = UILabel(frame: .zero)
    private lazy var dateLabel = UILabel(frame: .zero)
    private lazy var headerLabel = UILabel(frame: .zero)
    private lazy var bodyLabel = UILabel(frame: .zero)
    private lazy var image = UIImageView(frame: .zero)
    var currentNew: NewsModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = NewDetailPresenter(newDetailView: self,
                                       newsService: NewsServices(),
                                       newSelected: currentNew)
    }
    
    override func addSubviews() {
        view.addSubview(mainScrollView)
        view.addSubview(image)
        view.addSubview(closeButton)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(maskView)
        mainStackView.addArrangedSubview(contentFieldsStackView)
        contentFieldsStackView.addArrangedSubview(titleLabel)
        contentFieldsStackView.addArrangedSubview(dateLabel)
        contentFieldsStackView.addArrangedSubview(headerLabel)
        contentFieldsStackView.addArrangedSubview(bodyLabel)
        view.addSubview(loadingView)
        loadingView.addSubview(indicatorView)
    }
    
    override func addStyle() {
        view.backgroundColor = .white

        image.contentMode = . scaleAspectFill
        image.backgroundColor = .white
        
        contentFieldsStackView.backgroundColor = .white
        
        closeButton.setImage(CommonAssets.close.image.withRenderingMode(.alwaysTemplate), for: .normal)
        closeButton.contentMode = .scaleAspectFit
        closeButton.tintColor = .primaryColor
        closeButton.backgroundColor = .lightGray
        closeButton.layer.cornerRadius = 15
        
        titleLabel.font = .medium(18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
        titleLabel.backgroundColor = .white
        
        dateLabel.font = .regular(14)
        dateLabel.textColor = .lightGray
        dateLabel.textAlignment = .right
        dateLabel.backgroundColor = .white
        
        headerLabel.font = .medium(18)
        headerLabel.numberOfLines = 0
        headerLabel.textColor = .black
        headerLabel.backgroundColor = .white
        
        bodyLabel.font = .regular(14)
        bodyLabel.numberOfLines = 0
        bodyLabel.textColor = .black
        bodyLabel.backgroundColor = .white
        
        loadingView.backgroundColor = .black.withAlphaComponent(0.2)
        
        indicatorView.color = .white
        indicatorView.style = .medium
    }
    
    override func addConstraints() {
        mainScrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        mainStackView.snp.makeConstraints { (make) in
            make.top.equalTo(mainScrollView).inset(0)
            make.bottom.equalTo(mainScrollView).inset(10)
            make.left.right.equalTo(view)
            make.width.equalTo(mainScrollView)
        }
        
        image.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        closeButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(20)
            make.top.equalToSuperview().offset(25)
            make.width.height.equalTo(30)
        }
        
        maskView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        contentFieldsStackView.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalTo(view)
            make.width.equalTo(mainScrollView)
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
        
        contentFieldsStackView.axis = .vertical
        contentFieldsStackView.spacing = 10
        
        closeButton.addTarget(self, action: #selector(pressCloseButton), for: .touchUpInside)
        
        closeButton.isHidden = ManagerFilters().loadFilters()?.viewDetails != TypeFilterDetailView.present.index ? true : false
    }
    
    @objc func pressCloseButton() {
        dismiss(animated: true, completion: nil)
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
            image.kf.setImage(with: url, placeholder: CommonAssets.iconGrayApp.image)
            view.sendSubviewToBack(image)
            image.clipsToBounds = true
        }
        mainStackView.isHidden = false
    }
    
    func fetchNewItemError() {
        let alert = UIAlertController(title: "title_error".localized, message: "message_error".localized, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "try_again_button".localized, style: .default, handler: { _ in
            self.dismiss(animated: true) {
                
            }
        }))
        present(alert, animated: true, completion: nil)
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
