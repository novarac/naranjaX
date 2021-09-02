import UIKit

class StarRatingView: BaseView {

    private lazy var quantityStarLabel = UILabel(frame: .zero)
    private lazy var contentImages = UIStackView(frame: .zero)
        
    // MARK: BaseView
    
    override func addSubviews() {
        addSubview(quantityStarLabel)
        addSubview(contentImages)
    }

    override func addStyle() {
        backgroundColor = .red
        
        quantityStarLabel.font = .regular(12)
        quantityStarLabel.textAlignment = .center
        quantityStarLabel.textColor = .red
    }

    override func addConstraints() {
        quantityStarLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }

    override func addConfigurations() {
        quantityStarLabel.text = "3"
    }
    
    // MARK: Public Methods
    
    func configure(forQuantityStars quantityStars: String?) {
        quantityStarLabel.text = quantityStars
    }
}
