//

import Foundation
import ReactiveSwift

class AuthInteractor {
    private let userProvider: ReactiveUserProviderProtocol
    
    weak var presenter: AuthInteractorOutput?
    
    init(
        userProvider: ReactiveUserProviderProtocol
    ) {
        self.userProvider = userProvider
    }
}

private extension AuthInteractor {
    func processSignInResult(result: APIResponse.User.SignIn) {
        if (result.result) {
            presenter?.navigateToApp()
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
                self?.processSignInResult(result: result)
                
            case .failure(let error):
                print("signIn:", error)
                self?.handleError(error)
            }
        }
    }
}
