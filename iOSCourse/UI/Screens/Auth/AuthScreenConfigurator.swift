//

import Foundation
import UIKit

class AuthScreenConfigurator: Configurator {
    private let userProvider: ReactiveUserProviderProtocol
    
    init(
        userProvider: ReactiveUserProviderProtocol
    ) {
        self.userProvider = userProvider
    }
    
    func configure(router: RouterProtocol?) -> UIViewController {
        let interactor = AuthInteractor(
            userProvider: userProvider
        )
        let presenter = AuthPresenter(
            router: router,
            interactor: interactor
        )
        let viewController = AuthScreenViewController(
            presenter: presenter
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
