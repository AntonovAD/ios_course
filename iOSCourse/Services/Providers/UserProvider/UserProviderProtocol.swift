//

import Foundation
import ReactiveSwift

enum UserProviderError: Error {
    case signInError(_ error: Error?)
    case unknown
}

protocol UserProviderProtocol {
    func signIn(
        login: String,
        password: String,
        completion: @escaping (Result<APIResponse.User.SignIn, UserProviderError>) -> Void
    )
    func getUser(
        completion: @escaping (Result<User, UserProviderError>) -> Void
    )
}

protocol ReactiveUserProviderProtocol {
    func signIn(login: String, password: String) -> SignalProducer<APIResponse.User.SignIn, UserProviderError>
    func getUser() -> SignalProducer<User, UserProviderError>
}
