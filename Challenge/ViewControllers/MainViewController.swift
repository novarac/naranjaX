import UIKit

public protocol MainViewProtocol: AnyObject {
    
}

public class MainViewController: UIViewController {
    
    public override func viewDidLoad() {
        title = "title_home".localized
        view.backgroundColor = .white
    }
        
}
