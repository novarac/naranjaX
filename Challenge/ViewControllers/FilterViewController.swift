import UIKit

class FilterViewController: BaseViewController {
    
    public var presenter: FilterPresenter?
    private lazy var mainScrollView = UIScrollView(frame: .zero)
    private lazy var mainStackView = UIStackView(frame: .zero)
    private lazy var titleLabel = UILabel(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = FilterPresenter(filterView: self, newsService: NewsServices())
    }
    
    override func addSubviews() {
        view.addSubview(mainScrollView)
        mainScrollView.addSubview(mainStackView)
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    override func addStyle() {
        view.backgroundColor = .white
        
        mainScrollView.backgroundColor = .lightGray.withAlphaComponent(0.5)
        mainStackView.backgroundColor = .white
        
        titleLabel.font = .medium(18)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .black
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
        
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    override func addConfiguration() {
        title = "title_filter_item".localized
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 10
        mainStackView.isHidden = true
    }
}

extension FilterViewController: FilterProtocol {
    
}
