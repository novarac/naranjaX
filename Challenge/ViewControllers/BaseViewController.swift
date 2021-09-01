import UIKit

protocol BaseViewControllerProtocol {
    func addSubviews()
    func addConstraints()
    func addStyle()
}

class BaseViewController: UIViewController, BaseViewControllerProtocol {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addSubviews()
        addConstraints()
        addStyle()
        addConfiguration()
        
        navigationItem.backButtonTitle = ""
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    open func addSubviews() { }
    
    open func addConstraints() { }
    
    open func addStyle() { }
    
    open func addConfiguration() { }
    
    open func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
