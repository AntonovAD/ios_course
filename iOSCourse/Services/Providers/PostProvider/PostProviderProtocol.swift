//

import Foundation
import ReactiveSwift

enum PostProviderError: Error {
    case writeError(error: Error?)
}

protocol PostProviderProtocol {
    func requestAll(completion: @escaping (Result<[Post], PostProviderError>) -> Void)
}

protocol ReactivePostProviderProtocol {
    var posts: Property<[Post]> { get }
    func requestAll() -> SignalProducer<[Post], PostProviderError>
}
