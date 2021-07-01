//

import Foundation
import ReactiveSwift

enum UserProviderRealmError: Error {
    case writeError(_ error: Error?)
    case readError(_ error: Error?)
    case unknown
}

protocol UserProviderRealmProtocol {
    func getUser(
        completion: @escaping (Result<User, UserProviderRealmError>) -> Void
    )
    func initUser(
        by id: Int,
        with login: String, _ password: String,
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    )
    func updateUser(
        user: User,
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    )
    func deleteUser(
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    )
}

protocol ReactiveUserProviderRealmProtocol {
    func getUser() -> SignalProducer<User, UserProviderRealmError>
    func initUser(by id: Int, with login: String, _ password: String) -> SignalProducer<(), UserProviderRealmError>
    func updateUser(user: User) -> SignalProducer<(), UserProviderRealmError>
    func deleteUser() -> SignalProducer<(), UserProviderRealmError>
}
