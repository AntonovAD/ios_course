//

import UIKit

enum AssetsColor: String {
    case primary = "App Primary Color"
    case primaryFill = "App Primary Fill Color"
    case secondaryFill = "App Secondary Fill Color"
}

extension UIColor {
    static func appColor(_ name: AssetsColor) -> UIColor? {
         return UIColor(named: name.rawValue)
    }
}
