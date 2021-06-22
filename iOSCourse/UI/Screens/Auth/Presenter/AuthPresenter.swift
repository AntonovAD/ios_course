//

import Foundation

class AuthPresenter {
    private var router: RouterProtocol?
    
    private let interactor: AuthInteractorInput
    
    private var title = "Авторизация"
    
    weak var viewController: AuthScreenViewControllerInput?
    
    init(
        router: RouterProtocol?,
        interactor: AuthInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

private extension AuthPresenter {
    func updateTitle() {
        viewController?.updateTitle(title)
    }
}

extension AuthPresenter: AuthInteractorOutput {
    
}

extension AuthPresenter: AuthScreenViewControllerOutput {
    func viewIsReady() {
        updateTitle()
    }
}
