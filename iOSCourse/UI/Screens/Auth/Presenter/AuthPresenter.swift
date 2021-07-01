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
    
    func autoLogin() {
        interactor.autoLogin()
    }
}

extension AuthPresenter: AuthInteractorOutput {
    func navigateToApp() {
        router?.replace(.postList, config: (data: nil, from: .auth))
    }
    
    func handleError(_ error: Error) {
        
    }
}

extension AuthPresenter: AuthScreenViewControllerOutput {
    func viewIsReady() {
        autoLogin()
        
        updateTitle()
    }
    
    func didSelectSubmitButton(login: String, password: String) {
        interactor.signIn(login: login, password: password)
    }
}
