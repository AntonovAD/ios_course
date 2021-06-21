//

import Foundation
import UIKit

protocol MainNavigationFactoryProtocol {
    func createMainNavigationController(rootViewController: UIViewController) -> MainNavigationController
}

class MainNavigationFactory: MainNavigationFactoryProtocol {    
    func createMainNavigationController(rootViewController: UIViewController) -> MainNavigationController {
        let interactor = MainNavigationInteractor()
        let presenter = MainNavigationPresenter(
            interactor: interactor
        )
        let navigationController = MainNavigationController(
            rootViewController: rootViewController,
            presenter: presenter
        )
        
        interactor.presenter = presenter
        presenter.navigationController = navigationController
        
        return navigationController
    }
}
