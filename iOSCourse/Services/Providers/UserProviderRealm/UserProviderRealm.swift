//

import Foundation
import ReactiveSwift
import RealmSwift

class UserProviderRealm: UserProviderRealmProtocol {
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
    func getUser(
        completion: @escaping (Result<User, UserProviderRealmError>) -> Void
    ) {
        queue.async { [realmFactory] in
            switch realmFactory.createRealm() {
            case .success(let realm):
                let object = realm.object(ofType: UserRealm.self, forPrimaryKey: "single")
                
                guard let user: User = object?.toPlain() else {
                    return completion(.failure(.readError(nil)))
                }
                
                completion(.success(user))
                
            case .failure(let error):
                completion(.failure(.readError(error)))
            }
        }
    }
    
    func initUser(
        by id: Int,
        with login: String, _ password: String,
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    ) {
        queue.async { [realmFactory] in
            do {
                let realm = try realmFactory.createRealm().get()
                
                let user = User(
                    id: id,
                    name: login,
                    password: password,
                    email: "", created_at: "", updated_at: nil, deleted_at: nil
                )
                
                let realmObject = UserRealm(from: user)
                
                realm.beginWrite()
                
                realm.add(realmObject, update: .all)
                
                try realm.commitWrite()
                
                completion(.success(()))
            }
            catch {
                completion(.failure(.writeError(error)))
            }
        }
    }
    
    func updateUser(
        user: User,
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    ) {
        queue.async { [realmFactory] in
            do {
                let realm = try realmFactory.createRealm().get()
                
                let realmObject = UserRealm(from: user)
                
                realm.beginWrite()
                
                realm.add(realmObject, update: .all)
                
                try realm.commitWrite()
                
                completion(.success(()))
            }
            catch {
                completion(.failure(.writeError(error)))
            }
        }
    }
    
    func deleteUser(
        completion: @escaping (Result<(), UserProviderRealmError>) -> Void
    ) {
        queue.async { [realmFactory] in
            do {
                let realm = try realmFactory.createRealm().get()
                
                if let object = realm.object(ofType: UserRealm.self, forPrimaryKey: "single") {
                    realm.beginWrite()
                    
                    realm.delete(object)
                    
                    try realm.commitWrite()
                }
                
                completion(.success(()))
            }
            catch {
                completion(.failure(.writeError(error)))
            }
        }
    }
}

extension UserProviderRealm: ReactiveUserProviderRealmProtocol {
    // MARK: 🚀 Reactive
    func getUser() -> SignalProducer<User, UserProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.getUser { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func initUser(by id: Int, with login: String, _ password: String) -> SignalProducer<(), UserProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.initUser(by: id, with: login, password) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func updateUser(user: User) -> SignalProducer<(), UserProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.updateUser(user: user) { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    func deleteUser() -> SignalProducer<(), UserProviderRealmError> {
        return SignalProducer { [weak self] observer, _ in
            self?.deleteUser() { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}
