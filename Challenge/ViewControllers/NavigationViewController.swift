import UIKit

final class NavigationViewController: UINavigationController {
    
    // MARK: View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
    }
    
    // MARK: Private Methods
    
    private func addStyle() {
        setNavigationBarHidden(false, animated: false)

        navigationBar.backIndicatorImage = CommonAssets.backArrow.image.withRenderingMode(.alwaysTemplate)
        navigationBar.backIndicatorImage?.withTintColor(.white)
        navigationBar.backIndicatorTransitionMaskImage = CommonAssets.backArrow.image
        navigationBar.tintColor = .white
        navigationBar.barTintColor = .primaryColor
        navigationBar.isTranslucent = true

        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                              NSAttributedString.Key.font: UIFont.bold(16)]
        navigationBar.titleTextAttributes = textAttributes
        
        let attributes = [NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 0.1)!, NSAttributedString.Key.foregroundColor: UIColor.clear]

        let barButtonItemAppearance = UIBarButtonItem.appearance()
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .normal)
        barButtonItemAppearance.setTitleTextAttributes(attributes, for: .highlighted)
    }
}
