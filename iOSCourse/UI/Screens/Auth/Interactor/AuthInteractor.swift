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
    func processAuthResult(result: AuthResponse) {
        if (result.result) {
            presenter?.navigateToApp()
        } else {
            print("processAuthResult: 401")
        }
    }
    
    func handleError(_ error: Error) {
        presenter?.handleError(error)
    }
}

extension AuthInteractor: AuthInteractorInput {
    func authUser(login: String, password: String) {
        var producer = userProvider.auth(login: login, password: password)
        producer = producer
            .flatMap(.latest) { result in
                return SignalProducer(value: result)
            }
        
        producer.startWithResult { [weak self] result in
            switch result {
            case .success(let result):
                self?.processAuthResult(result: result)
                
            case .failure(let error):
                self?.handleError(error)
            }
        }
    }
}
