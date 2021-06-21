//

import Foundation
import UIKit

class MainNavigationController: UINavigationController {
    private var presenter: MainNavigationControllerOutput?
    
    convenience init(
        rootViewController: UIViewController,
        presenter: MainNavigationControllerOutput
    ) {
        self.init(rootViewController: rootViewController)
        
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.viewIsReady()
    }
}

extension MainNavigationController: MainNavigationControllerInput {
    
}
