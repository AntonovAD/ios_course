//

import Foundation
import ReactiveSwift

class UserProvider: UserProviderProtocol, ReactiveUserProviderProtocol {
    private let queue: DispatchQueue
    private let requestService: RequestServiceProtocol
    
    private let mutableUser = MutableProperty<User?>(nil)
    let user: Property<User?>
    
    init(
        queue: DispatchQueue,
        requestService: RequestServiceProtocol
    ) {
        self.queue = queue
        self.requestService = requestService
        self.user = Property(mutableUser)
    }
    
    // MARK: 🐌 Not Reactive
    func signIn(
        login: String,
        password: String,
        completion: @escaping (Result<APIResponse.User.SignIn, UserProviderError>) -> Void
    ) {
        queue.async {
            self.requestService.send(request: API.User.SignIn(
                APIRequest.User.SignIn(
                    login: login,
                    password: password
                )
            )) { result in
                switch result {
                case .success(let response):
                    completion(.success((response)))
                    
                case .failure(let error):
                    completion(.failure(.signInError(error)))
                }
            }
        }
    }
    
    func getUser(
        completion: @escaping (Result<User, UserProviderError>) -> Void
    ) {
        
    }
    
    func updateUser(
        user: User,
        completion: @escaping (Result<(), UserProviderError>) -> Void
    ) {
        queue.async {
            completion(.success(()))
        }
    }
    
    // MARK: 🚀 Reactive
    func signIn(login: String, password: String) -> SignalProducer<APIResponse.User.SignIn, UserProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.signIn(login: login, password: password) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func getUser() -> SignalProducer<User, UserProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.getUser() { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func updateUser(user: User) -> SignalProducer<(), UserProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.updateUser(user: user) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}
