//

import Foundation
import UIKit

class AuthScreenConfigurator: Configurator {
    private let userProvider: ReactiveUserProviderProtocol
    private let userProviderRealm: ReactiveUserProviderRealmProtocol
    
    init(
        userProvider: ReactiveUserProviderProtocol,
        userProviderRealm: ReactiveUserProviderRealmProtocol
    ) {
        self.userProvider = userProvider
        self.userProviderRealm = userProviderRealm
    }
    
    func configure(router: RouterProtocol?) -> UIViewController {
        let interactor = AuthInteractor(
            userProvider: userProvider,
            userProviderRealm: userProviderRealm
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
