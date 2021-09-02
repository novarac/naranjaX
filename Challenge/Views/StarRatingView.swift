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
        quantityStarLabel.font = .medium(12)
        quantityStarLabel.textAlignment = .center
        quantityStarLabel.textColor = .red
    }

    override func addConstraints() {
        quantityStarLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(contentImages.snp.trailing).offset(10)
            make.centerY.equalToSuperview()
        }
        
        contentImages.snp.makeConstraints { make in
            make.leading.top.bottom.equalToSuperview()
            make.width.equalTo(70)
        }
    }

    override func addConfigurations() {
        contentImages.axis = .horizontal
        contentImages.distribution = .fillEqually
        contentImages.spacing = 2
    }
    
    // MARK: Public Methods
    
    func configure(forQuantityStars quantityStars: String) {
        quantityStarLabel.text = "" //quantityStars
        contentImages.removeAllArrangedSubviews()
        for starIndex in 0...5 {
            let star = StarView(frame: .zero)
            contentImages.addArrangedSubview(star)
            if starIndex > Int(quantityStars) ?? 0 {
                star.configure(isOn: false)
            } else {
                star.configure(isOn: true)
            }
        }
    }
}
