//

import Foundation
import ReactiveSwift
import RealmSwift

class PostProviderRealm: PostProviderRealmProtocol {
    private let realmFactory: RealmFactoryProtocol
    private let queue: DispatchQueue
    
    init(
        realmFactory: RealmFactoryProtocol,
        queue: DispatchQueue
    ) {
        self.realmFactory = realmFactory
        self.queue = queue
    }
    
    // MARK: 🐌 Not Reactive
    func requestAll(completion: @escaping (Result<[Post], PostProviderRealmError>) -> Void) {
        queue.async { [realmFactory] in
            switch realmFactory.createRealm() {
            case .success(let realm):
                let objects = realm.objects(PostRealm.self)
                
                let posts: [Post] = objects.map { $0.toPlain() }
                
                completion(.success(posts))
                
            case .failure(let error):
                completion(.failure(.databaseError(error: error)))
            }
        }
    }
    
    func update(post: Post, completion: @escaping (Result<(), PostProviderRealmError>) -> Void) {
        queue.async { [realmFactory] in
            do {
                let realm = try realmFactory.createRealm().get()
                
                let realmObject = PostRealm(from: post)
                
                realm.beginWrite()
                
                realm.add(realmObject, update: .all)
                
                try realm.commitWrite()
                
                completion(.success(()))
            }
            catch {
                completion(.failure(.writeError(error: error)))
            }
        }
    }
    
    func update(posts: [Post], completion: @escaping (Result<(), PostProviderRealmError>) -> Void) {
        queue.async { [realmFactory] in
            do {
                let realm = try realmFactory.createRealm().get()
                
                let realmObjects = posts.lazy.map { PostRealm(from: $0) }
                
                realm.beginWrite()
                
                realm.add(realmObjects)
                
                try realm.commitWrite()
                
                completion(.success(()))
            }
            catch {
                completion(.failure(.writeError(error: error)))
            }
        }
    }
}

extension PostProviderRealm: ReactivePostProviderRealmProtocol {
    // MARK: 🚀 Reactive
    func requestAll() -> SignalProducer<[Post], PostProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.requestAll { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func update(post: Post) -> SignalProducer<(), PostProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.update(post: post) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func update(posts: [Post]) -> SignalProducer<(), PostProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.update(posts: posts) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}
