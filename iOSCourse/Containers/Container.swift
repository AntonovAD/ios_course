//

import Foundation
import Swinject

/*private enum Environment {
    case development
    case production
}

private let ENVIRONMENT: Environment = .development*/

class DataStorageAssembly: Assembly {
    private lazy var userDefaults = UserDefaults.standard
    
    func assemble(container: Container) {
        container.register(KeyValueDataStorage.self) { [userDefaults] resolver in
            KeyValueDataStorage(userDefaults: userDefaults)
        }
        .implements(PostMigrationDataStorage.self)
    }
}

class ServiceAssembly: Assembly {
    private lazy var queue = DispatchQueue(label: "database-queue", attributes: .concurrent)
    private lazy var requestService = RequestServiceURLSession(session: URLSession(configuration: .default))
    
    private let postProviderIsMock = true
    private let userProviderIsMock = false
    
    func assemble(container: Container) {
        container.register(PostProviderProtocol.self) { _ in
            PostProviderMock()
        }
        container.register(ReactivePostProviderProtocol.self) { _ in
            PostProviderMock()
        }
        
        /*container.register(PostProviderRealm.self) { [queue] resolver in
            PostProviderRealm(
                realmFactory: resolver.resolve(RealmFactoryProtocol.self)!,
                queue: queue
            )
        }
        .inObjectScope(.container)
        .implements(PostProviderProtocol.self)
        .implements(ReactivePostProviderProtocol.self)
        
        container.register(PostMigrationServiceProtocol.self) { [queue] resolver in
            PostMigrationService(
                postProvider: resolver.resolve(PostProviderProtocol.self)!,
                dataStorage: resolver.resolve(PostMigrationDataStorage.self)!,
                queue: queue
            )
        }*/
        
        if (userProviderIsMock) {
            container.register(UserProviderProtocol.self) { [queue] _ in
                UserProviderMock(queue: queue)
            }
            container.register(ReactiveUserProviderProtocol.self) { [queue] _ in
                UserProviderMock(queue: queue)
            }
        } else {
            container.register(UserProviderProtocol.self) { [queue, requestService] _ in
                UserProvider(
                    queue: queue,
                    requestService: requestService
                )
            }
            container.register(ReactiveUserProviderProtocol.self) { [queue, requestService] _ in
                UserProvider(
                    queue: queue,
                    requestService: requestService
                )
            }
        }
        
        container.register(RouterProtocol.self) { resolver in
            Router(
                authScreen: resolver.resolve(AuthScreenConfigurator.self)!,
                postListScreen: resolver.resolve(PostListScreenConfigurator.self)!,
                postScreen: resolver.resolve(PostScreenConfigurator.self)!,
                userProvider: resolver.resolve(UserProviderProtocol.self)!
            )
        }
    }
}

class ConfiguratorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AuthScreenConfigurator.self) { resolver in
            AuthScreenConfigurator(
                userProvider: resolver.resolve(ReactiveUserProviderProtocol.self)!
            )
        }
        
        container.register(PostListScreenConfigurator.self) { resolver in
            PostListScreenConfigurator(
                postProvider: resolver.resolve(PostProviderProtocol.self)!,
                reactivePostProvider: resolver.resolve(ReactivePostProviderProtocol.self)!,
                postListTableDataProviderFactory: resolver.resolve(TableDataProviderFactoryProtocol.self)!,
                cellPresenterFactory: resolver.resolve(PostCardViewPresenterFactoryProtocol.self)!,
                userProvider: resolver.resolve(ReactiveUserProviderProtocol.self)!
            )
        }
        
        container.register(PostScreenConfigurator.self) { resolver in
            PostScreenConfigurator(
                postTableDataProviderFactory: resolver.resolve(TableDataProviderFactoryProtocol.self)!,
                postTitlePresenterFactory: resolver.resolve(PostTitleViewPresenterFactoryProtocol.self)!,
                postInfoPresenterFactory: resolver.resolve(PostInfoViewPresenterFactoryProtocol.self)!,
                postTextPresenterFactory: resolver.resolve(PostTextViewPresenterFactoryProtocol.self)!,
                postTagsCollectionPresenterFactory: resolver.resolve(PostTagsCollectionViewPresenterFactoryProtocol.self)!,
                postRatingPresenterFactory: resolver.resolve(PostRatingViewPresenterFactoryProtocol.self)!
            )
        }
    }
}

class FactoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(RealmFactoryProtocol.self) { _ in
            RealmFactory()
        }
        
        container.register(TableDataProviderFactoryProtocol.self) { _ in
            TableDataProviderFactory()
        }
        
        container.register(CollectionDataProviderFactoryProtocol.self) { _ in
            CollectionDataProviderFactory()
        }
        
        container.register(PostCardViewPresenterFactoryProtocol.self) { resolver in
            PostCardViewPresenterFactory(
                tagsCollectionDataProviderFactory: resolver.resolve(CollectionDataProviderFactoryProtocol.self)!
            )
        }
        
        container.register(PostTitleViewPresenterFactoryProtocol.self) { _ in
            PostTitleViewPresenterFactory()
        }
        container.register(PostInfoViewPresenterFactoryProtocol.self) { _ in
            PostInfoViewPresenterFactory()
        }
        container.register(PostTextViewPresenterFactoryProtocol.self) { _ in
            PostTextViewPresenterFactory()
        }
        container.register(PostTagsCollectionViewPresenterFactoryProtocol.self) { resolver in
            PostTagsCollectionViewPresenterFactory(
                tagsCollectionDataProviderFactory: resolver.resolve(CollectionDataProviderFactoryProtocol.self)!
            )
        }
        container.register(PostRatingViewPresenterFactoryProtocol.self) { _ in
            PostRatingViewPresenterFactory()
        }
    }
}

protocol AppServiceProtocol {
    func start() -> RouterProtocol
}

class AppService: AppServiceProtocol {
    private let assembler: Assembler
    
    private var resolver: Resolver {
        assembler.resolver
    }
    
    init() {
        let dataStorageAssembly = DataStorageAssembly()
        let serviceAssembly = ServiceAssembly()
        let factoryAssembly = FactoryAssembly()
        let configuratorAssembly = ConfiguratorAssembly()
        
        assembler = Assembler([
            dataStorageAssembly,
            serviceAssembly,
            factoryAssembly,
            configuratorAssembly
        ])
    }
    
    func start() -> RouterProtocol {
        //migration()
        
        return resolver.resolve(RouterProtocol.self)!
    }
    
    private func migration() {
        let postMigrationService = resolver.resolve(PostMigrationServiceProtocol.self)
        postMigrationService?.migrateIfNeeded()
    }
}
