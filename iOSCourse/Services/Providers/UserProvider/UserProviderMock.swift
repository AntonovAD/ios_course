//

import Foundation
import ReactiveSwift

class UserProviderMock: UserProviderProtocol, ReactiveUserProviderProtocol {
    private let mutableUser = MutableProperty<User?>(nil)
    let user: Property<User?>
    
    init() {
        user = Property(mutableUser)
    }
    
    // MARK: 🐌 Not Reactive
    func auth(
        login: String,
        password: String,
        completion: @escaping (Result<AuthResponse, UserProviderError>) -> Void
    ) {
        DispatchQueue.main.async {
            let data = authMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let response = try! jsonDecoder.decode(AuthResponse.self, from: data)
            
            completion(.success((response)))
        }
    }
    
    func getUser(
        completion: @escaping (Result<User, UserProviderError>) -> Void
    ) {
        //let userId = storage.getUserId()
        
        DispatchQueue.main.async {
            let data = userMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let user = try! jsonDecoder.decode(User.self, from: data)
            
            completion(.success(user))
        }
    }
    
    func update(user: User, completion: @escaping (Result<(), UserProviderError>) -> Void) {
        DispatchQueue.main.async {
            completion(.success(()))
        }
    }
    
    // MARK: 🚀 Reactive
    func auth(login: String, password: String) -> SignalProducer<AuthResponse, UserProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.auth(login: login, password: password) { result in
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
    
    func update(user: User) -> SignalProducer<(), UserProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.update(user: user) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}

private let authMockJson = """
{
    "result":true,
    "userId":1
}
"""

private let userMockJson = """
{
    "id":1,
    "name":"antonov.ad",
    "email":"an_42@mail.ru",
    "email_verified_at":null,
    "password":"antonov.ad",
    "remember_token":null,
    "created_at":"2020-10-01 16:21:35",
    "updated_at":null,
    "deleted_at":null
}
"""
