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
    func assemble(container: Container) {
        container.register(PostProviderProtocol.self) { _ in
            PostProviderMock()
        }
        container.register(ReactivePostProviderProtocol.self) { _ in
            PostProviderMock()
        }
        
        /*container.register(PostProviderRealm.self) { resolver in
            PostProviderRealm(
                realmFactory: resolver.resolve(RealmFactoryProtocol.self)!
            )
        }
        .inObjectScope(.container)
        .implements(PostProviderProtocol.self)
        .implements(ReactivePostProviderProtocol.self)
        
        container.register(PostMigrationServiceProtocol.self) { resolver in
            PostMigrationService(
                postProvider: resolver.resolve(PostProviderProtocol.self)!,
                dataStorage: resolver.resolve(PostMigrationDataStorage.self)!
            )
        }*/
        
        container.register(UserProviderProtocol.self) { _ in
            UserProviderMock()
        }
        
        container.register(RouterProtocol.self) { resolver in
            Router(
                authScreen: resolver.resolve(PostListScreenConfigurator.self)!,
                postListScreen: resolver.resolve(PostListScreenConfigurator.self)!,
                postScreen: resolver.resolve(PostListScreenConfigurator.self)!,
                userProvider: resolver.resolve(UserProviderProtocol.self)!
            )
        }
    }
}

class ConfiguratorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PostListScreenConfigurator.self) { resolver in
            PostListScreenConfigurator(
                postProvider: resolver.resolve(PostProviderProtocol.self)!,
                reactivePostProvider: resolver.resolve(ReactivePostProviderProtocol.self)!,
                postListTableDataProviderFactory: resolver.resolve(TableDataProviderFactoryProtocol.self)!,
                cellPresenterFactory: resolver.resolve(PostCardViewPresenterFactoryProtocol.self)!,
                navigationControllerFactory: resolver.resolve(MainNavigationFactoryProtocol.self)!
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
        
        container.register(MainNavigationFactoryProtocol.self) { _ in
            MainNavigationFactory()
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
    
    /*private func migration() {
        let postMigrationService = resolver.resolve(PostMigrationServiceProtocol.self)
        postMigrationService?.migrateIfNeeded()
    }*/
}
