//

import Foundation
import ReactiveSwift

class AuthInteractor {
    private let userProvider: ReactiveUserProviderProtocol
    private let userProviderRealm: ReactiveUserProviderRealmProtocol
    
    weak var presenter: AuthInteractorOutput?
    
    init(
        userProvider: ReactiveUserProviderProtocol,
        userProviderRealm: ReactiveUserProviderRealmProtocol
    ) {
        self.userProvider = userProvider
        self.userProviderRealm = userProviderRealm
    }
}

private extension AuthInteractor {
    func processSignInResult(
        result: APIResponse.User.SignIn,
        login: String,
        password: String
    ) {
        if (result.result) {
            userProviderRealm.initUser(by: result.userId, with: login, password)
            .startWithResult { [weak self] result in
                
                switch result {
                case .success():
                    self?.presenter?.navigateToApp()
                    
                case .failure(let error):
                    self?.handleError(error)
                }
            }
        } else {
            print("processSignInResult: 401")
        }
    }
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
}

extension AuthInteractor: AuthInteractorInput {
    func signIn(login: String, password: String) {
        var producer = userProvider.signIn(login: login, password: password)
        producer = producer
            .flatMap(.latest) { result in
                return SignalProducer(value: result)
            }
        
        producer.startWithResult { [weak self] result in
            switch result {
            case .success(let result):
                print("signIn:", result)
                self?.processSignInResult(
                    result: result,
                    login: login,
                    password: password
                )
                
            case .failure(let error):
                print("signIn:", error)
                self?.handleError(error)
            }
        }
    }
    
    func autoLogin() {
        userProviderRealm.getUser()
        .startWithResult { [weak self] result in
            switch result {
            case .success(let user):
                self?.signIn(login: user.name, password: user.password)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
}
