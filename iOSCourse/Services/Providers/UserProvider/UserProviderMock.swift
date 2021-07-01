//

import Foundation
import ReactiveSwift

class UserProviderMock: UserProviderProtocol, ReactiveUserProviderProtocol {
    private let queue: DispatchQueue
    
    private let mutableUser = MutableProperty<User?>(nil)
    let user: Property<User?>
    
    init(
        queue: DispatchQueue
    ) {
        self.queue = queue
        self.user = Property(mutableUser)
    }
    
    // MARK: 🐌 Not Reactive
    func signIn(
        login: String,
        password: String,
        completion: @escaping (Result<APIResponse.User.SignIn, UserProviderError>) -> Void
    ) {
        queue.async {
            let data = signInUserMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let response = try! jsonDecoder.decode(APIResponse.User.SignIn.self, from: data)
            
            completion(.success((response)))
        }
    }
    
    func getUser(
        completion: @escaping (Result<User, UserProviderError>) -> Void
    ) {
        queue.async {
            let data = getUserMockJson.data(using: .utf8)!
            let jsonDecoder = JSONDecoder()
            let user = try! jsonDecoder.decode(User.self, from: data)
            
            completion(.success(user))
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
}

private let signInUserMockJson = """
{
    "result":true,
    "userId":1
}
"""

private let getUserMockJson = """
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
