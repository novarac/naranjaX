import UIKit

class SplashScreenView: BaseView {

    private lazy var splashImage = UIImageView(frame: .zero)
        
    override func addSubviews() {
        addSubview(splashImage)
    }
    
    override func addStyle() {
        backgroundColor = .white.withAlphaComponent(0.7)
        splashImage.image = CommonAssets.naranjaXlogoSplash.image
        splashImage.contentMode = .scaleAspectFill
    }

    override func addConstraints() {
        splashImage.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(50)
        }
    }

    override func addConfigurations() {

    }
}
