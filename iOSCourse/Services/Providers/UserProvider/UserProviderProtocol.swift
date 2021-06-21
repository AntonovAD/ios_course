//

import Foundation
import ReactiveSwift

enum UserProviderError: Error {
    case databaseError(error: Error)
    case writeError(error: Error?)
    case unknown
}

protocol UserProviderProtocol {
    func auth(
        login: String,
        password: String,
        completion: @escaping (Result<AuthResponse, UserProviderError>) -> Void
    )
    func getUser(
        completion: @escaping (Result<User, UserProviderError>) -> Void
    )
    func update(
        user: User,
        completion: @escaping (Result<(), UserProviderError>) -> Void
    )
}

protocol ReactiveUserProviderProtocol {
    func auth(login: String, password: String) -> SignalProducer<AuthResponse, UserProviderError>
    func getUser() -> SignalProducer<User, UserProviderError>
    func update(user: User) -> SignalProducer<(), UserProviderError>
}
