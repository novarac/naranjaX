import UIKit

class ToastMessageView: BaseView {

    private lazy var startImage = UIImageView(frame: .zero)
        
    override func addSubviews() {
        
    }
    
    override func addStyle() {
        backgroundColor = .primaryColor.withAlphaComponent(0.9)
    }

    override func addConstraints() {
        
    }

    override func addConfigurations() {

    }
    
    func showMessage(message: String) {
        
    }
}
