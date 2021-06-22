//

import UIKit
import Foundation

protocol Configurator {
    func configure(router: RouterProtocol?) -> (UINavigationController, UIViewController)
}
