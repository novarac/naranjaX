import UIKit

extension UITextField {

    func addPaddingLeft(padding: CGFloat) {
        let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: padding, height: 2.0))
        self.leftView = leftView
        leftViewMode = .always
    }
}
