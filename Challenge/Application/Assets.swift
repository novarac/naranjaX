import UIKit

protocol AssetsProvider {
    var name: String { get }
    var image: UIImage { get }
}

// Common
enum CommonAssets: String, AssetsProvider {
    case naranjaXlogoSplash = "NaranjaXlogoSplash"
    case backArrow = "BackArrow"
    case noNews = "NoNews"
    
    var name: String { rawValue }
    var image: UIImage { UIImage(named: rawValue)! }
}
