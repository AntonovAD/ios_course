//

import Foundation
import ReactiveSwift

enum PostProviderError: Error {
    case noContent(_ error: Error?)
    case unknown
}

protocol PostProviderProtocol {
    func requestAll(completion: @escaping (Result<[Post], PostProviderError>) -> Void)
    func update(post: Post, completion: @escaping (Result<(), PostProviderError>) -> Void)
    func update(posts: [Post], completion: @escaping (Result<(), PostProviderError>) -> Void)
}

protocol ReactivePostProviderProtocol {
    func requestAll() -> SignalProducer<[Post], PostProviderError>
    func update(post: Post) -> SignalProducer<(), PostProviderError>
    func update(posts: [Post]) -> SignalProducer<(), PostProviderError>
}
