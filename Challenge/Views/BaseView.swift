import UIKit

class BaseView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews()
        addConstraints()
        addStyle()
        addConfigurations()
    }
    
    init() {
        super.init(frame: .zero)
        
        addSubviews()
        addConstraints()
        addStyle()
        addConfigurations()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addSubviews() {
        
    }
    
    open func addConstraints() {
        
    }
    
    open func addStyle() {
        
    }
    
    open func addConfigurations() {
        
    }
}
