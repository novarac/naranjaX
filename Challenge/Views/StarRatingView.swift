import UIKit

class StarRatingView: BaseView {

    private lazy var contentImages = UIStackView(frame: .zero)
        
    // MARK: BaseView
    
    override func addSubviews() {
        addSubview(contentImages)
    }

    override func addStyle() {

    }

    override func addConstraints() {
        contentImages.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    override func addConfigurations() {
        contentImages.axis = .horizontal
        contentImages.distribution = .fillEqually
        contentImages.spacing = 2
    }
    
    // MARK: Public Methods
    
    func configure(forQuantityStars quantityStars: String) {
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
