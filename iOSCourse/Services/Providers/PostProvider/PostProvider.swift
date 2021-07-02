//

import Foundation
import ReactiveSwift

class PostProvider: PostProviderProtocol, ReactivePostProviderProtocol {
    private let queue: DispatchQueue
    private let requestService: RequestServiceProtocol
    
    private let mutablePosts = MutableProperty<[Post]>([])
    let posts: Property<[Post]>

    init(
        queue: DispatchQueue,
        requestService: RequestServiceProtocol
    ) {
        self.queue = queue
        self.requestService = requestService
        
        posts = Property(mutablePosts)
        mutablePosts <~ requestAll().flatMapError { _ in .init(value: []) }
    }

    // MARK: 🐌 Not Reactive
    func requestAll(
        completion: @escaping (Result<[Post], PostProviderError>) -> Void
    ) {
        queue.async {
            self.requestService.send(request: API.Post.GetRecent(
                APIRequest.Post.GetRecent()
            )) { result in
                switch result {
                case .success(let response):
                    completion(.success((response)))
                    
                case .failure(let error):
                    completion(.failure(.noContent(error)))
                }
            }
        }
    }

    func update(
        post: Post,
        completion: @escaping (Result<(), PostProviderError>) -> Void
    ) {
        queue.async {
            completion(.success(()))
        }
    }

    func update(
        posts: [Post],
        completion: @escaping (Result<(), PostProviderError>) -> Void
    ) {
        queue.async {
            completion(.success(()))
        }
    }
    
    func rate(
        post: Post,
        value: Int,
        completion: @escaping (Result<Post, PostProviderError>) -> Void
    ) {
        queue.async {
            self.requestService.send(request: API.Post.Rate(
                APIRequest.Post.Rate(
                    postId: post.id,
                    value: value
                )
            )) { result in
                switch result {
                case .success(let response):
                    completion(.success((response)))
                    
                case .failure(let error):
                    completion(.failure(.noContent(error)))
                }
            }
        }
    }

    // MARK: 🚀 Reactive
    func requestAll() -> SignalProducer<[Post], PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.requestAll { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }

    func update(post: Post) -> SignalProducer<(), PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.update(post: post) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }

    func update(posts: [Post]) -> SignalProducer<(), PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.update(posts: posts) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func rate(post: Post, value: Int) -> SignalProducer<Post, PostProviderError> {
        return SignalProducer { [weak self] observer, lifetime in
            self?.rate(post: post, value: value) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}
