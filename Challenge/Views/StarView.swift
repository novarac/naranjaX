import UIKit

class StarView: BaseView {

    private lazy var startImage = UIImageView(frame: .zero)
        
    override func addSubviews() {
        addSubview(startImage)
    }
    
    override func addStyle() {
        startImage.image = CommonAssets.star.image.withRenderingMode(.alwaysTemplate)
        startImage.contentMode = .scaleAspectFill
    }

    override func addConstraints() {
        startImage.snp.makeConstraints { make in
            make.width.height.equalTo(10)
        }
    }

    override func addConfigurations() {

    }
    
    func configure(isOn: Bool) {
        if isOn {
            startImage.tintColor = .primaryColor
        } else {
            startImage.tintColor = .lightGray.withAlphaComponent(0.2)
        }
    }
}
