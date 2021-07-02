//

import Foundation
import ReactiveSwift

enum PostProviderRealmError: Error {
    case databaseError(error: Error)
    case writeError(error: Error?)
    case unknown
}

protocol PostProviderRealmProtocol {
    func requestAll(completion: @escaping (Result<[Post], PostProviderRealmError>) -> Void)
    func update(post: Post, completion: @escaping (Result<(), PostProviderRealmError>) -> Void)
    func update(posts: [Post], completion: @escaping (Result<(), PostProviderRealmError>) -> Void)
}

protocol ReactivePostProviderRealmProtocol {
    func requestAll() -> SignalProducer<[Post], PostProviderRealmError>
    func update(post: Post) -> SignalProducer<(), PostProviderRealmError>
    func update(posts: [Post]) -> SignalProducer<(), PostProviderRealmError>
}
