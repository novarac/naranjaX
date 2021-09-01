import UIKit

protocol Font {
    var name: String { get }
}

enum Roboto: String, Font {
    case medium = "Roboto-Medium"
    case light = "Roboto-Light"
    case regular = "Roboto-Regular"
    case mediumItalic = "Roboto-MediumItalic"
    case thinItalic = "Roboto-ThinItalic"
    case boldItalic = "Roboto-BoldItalic"
    case lightItalic = "Roboto-LightItalic"
    case italic = "Roboto-Italic"
    case blackItalic = "Roboto-BlackItalic"
    case bold = "Roboto-Bold"
    case thin = "Roboto-Thin"
    case black = "Roboto-Black"

    var name: String { rawValue }
}

extension UIFont {

    convenience init(font: Font, size: CGFloat) {
        self.init(name: font.name, size: size)!
    }
    
    class func medium(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.medium, size: size)
    }
    
    class func light(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.light, size: size)
    }
    
    class func regular(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.regular, size: size)
    }
    
    class func mediumItalic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.mediumItalic, size: size)
    }
    
    class func thinItalic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.thinItalic, size: size)
    }
    
    class func boldItalic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.boldItalic, size: size)
    }
    
    class func lightItalic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.lightItalic, size: size)
    }
    
    class func italic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.italic, size: size)
    }
    
    class func blackItalic(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.blackItalic, size: size)
    }
    
    class func bold(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.bold, size: size)
    }
    
    class func thin(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.thin, size: size)
    }
    
    class func black(_ size: CGFloat) -> UIFont {
        UIFont(font: Roboto.black, size: size)
    }
}
