//

import Foundation
import ReactiveSwift
import RealmSwift

enum PostMigrationServiceError: Error {
    case preseedError(Error?)
}

protocol PostMigrationServiceProtocol: MigrationServiceProtocol, ReactiveMigrationServiceProtocol {
    func migrateIfNeeded()
}

class PostMigrationService: PostMigrationServiceProtocol {
    private let postProvider: PostProviderProtocol
    private let dataStorage: PostMigrationDataStorage
    private let queue: DispatchQueue
    
    init(
        postProvider: PostProviderProtocol,
        dataStorage: PostMigrationDataStorage,
        queue: DispatchQueue
    ) {
        self.postProvider = postProvider
        self.dataStorage = dataStorage
        self.queue = queue
    }
    
    func migrateIfNeeded() {
        print("PostMigrationService - migrationVersion:", dataStorage.migrationVersion)
        
        // 🐌 Not Reactive
        let _: Void = migrate()
        
        // 🚀 Reactive
        //migrate().start()
    }

    //MARK: - 🐌 Not Reactive
    func migrate() {
        print("PostMigrationService - migrate()")
        
        var migrations: [() -> Void] = []
        var migrationError: Error? = nil

        let dispatchGroup = DispatchGroup()

        migrations.append {
            self.preseed() { result in
                switch result {
                case .success:
                    break

                case .failure(let error):
                    migrationError = error
                }

                dispatchGroup.leave()
            }
        }

        migrations.append {
            self.anotherMigration() { result in
                switch result {
                case .success:
                    break

                case .failure(let error):
                    migrationError = error
                }

                dispatchGroup.leave()
            }
        }

        queue.async { [dataStorage] in
            for i in 0 ..< migrations.count {
                guard migrationError == nil else {
                    break
                }

                if dataStorage.migrationVersion <= i {
                    dispatchGroup.enter()
                    migrations[i]()
                    dispatchGroup.wait()
                }
            }
        }
    }
    
    private func preseed(completion: @escaping (Result<(), PostMigrationServiceError>) -> Void) {
        print("PostMigrationService - preseed(completion:) -> Void")
        
        queue.async { [postProvider, dataStorage] in
            guard let path = Bundle.main.path(forResource: "Posts", ofType: "json") else {
                completion(.success(()))
                return
            }
            
            let url = URL(fileURLWithPath: path)
            
            do {
                let data = try Data(contentsOf: url)
                
                let decoder = JSONDecoder()
                
                let posts = try decoder.decode([Post].self, from: data)
                
                postProvider.update(posts: posts) { result in
                    if case .success = result {
                        dataStorage.migrationVersion = 1
                    }
                    
                    completion(result.mapError { .preseedError($0) })
                }
            }
            catch {
                completion(.failure(.preseedError(error)))
            }
        }
    }
    
    private func anotherMigration(completion: @escaping (Result<(), PostMigrationServiceError>) -> Void) {
        print("PostMigrationService - anotherMigration(completion:) -> Void")
        
        queue.async {
            //dataStorage.migrationVersion = 2
            
            completion(.success(()))
        }
    }
    
    //MARK: - 🚀 Reactive
    func migrate() -> SignalProducer<(), Never> {
        print("PostMigrationService - migrate() -> SignalProducer<(), Never>")
        
        var migrationProducer: SignalProducer<(), PostMigrationServiceError> = .empty
        
        switch dataStorage.migrationVersion {
        case 0:
            migrationProducer = migrationProducer.then(preseed())
            fallthrough
            
        case 1:
            migrationProducer = migrationProducer.then(anotherMigration())
            fallthrough

        default:
            break
        }
        
        return migrationProducer.flatMapError { _ in .init(value: ()) }
    }
    
    private func preseed() -> SignalProducer<(), PostMigrationServiceError> {
        print("PostMigrationService - preseed() -> SignalProducer<(), PostMigrationServiceError>")
        
        return SignalProducer { [weak self] observer, _ in
            self?.preseed { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
    
    private func anotherMigration() -> SignalProducer<(), PostMigrationServiceError> {
        print("PostMigrationService - anotherMigration() -> SignalProducer<(), PostMigrationServiceError>")
        
        return SignalProducer { [weak self] observer, _ in
            self?.anotherMigration { result in
                observer.send(value: result)
                observer.sendCompleted()
            }
        }
        .dematerializeResults()
    }
}
