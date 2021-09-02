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
    case filter = "Filter"
    case iconApp = "IconApp"
    case iconGrayApp = "IconGrayApp"
    case star = "Star"
    case naranjaXlogoNavBar = "NaranjaXlogoNavBar"
    
    var name: String { rawValue }
    var image: UIImage { UIImage(named: rawValue)! }
}
