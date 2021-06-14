//

import Foundation
import Swinject

class ServiceAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PostProviderProtocol.self) { _ in
            PostProviderMock()
        }
        container.register(ReactivePostProviderProtocol.self) { _ in
            PostProviderMock()
        }
    }
}

class ConfiguratorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(PostListConfigurator.self) { resolver in
            PostListConfigurator(
                postProvider: resolver.resolve(PostProviderProtocol.self)!,
                reactivePostProvider: resolver.resolve(ReactivePostProviderProtocol.self)!,
                postListTableDataProviderFactory: resolver.resolve(TableDataProviderFactory<PostCardViewPresenter>.self)!,
                cellPresenterFactory: resolver.resolve(PostCardViewPresenterFactoryProtocol.self)!
            )
        }
    }
}

class FactoryAssembly: Assembly {
    func assemble(container: Container) {
        container.register(TableDataProviderFactory<PostCardViewPresenter>.self) { _ in
            TableDataProviderFactory<PostCardViewPresenter>()
        }
        
        container.register(PostCardViewPresenterFactoryProtocol.self) { _ in
            namePostCardViewPresenterFactory()
        }
    }
}

protocol AppServiceProtocol {
    func start() -> Configurator
}

class AppService: AppServiceProtocol {
    private let assembler: Assembler
    
    private var resolver: Resolver {
        assembler.resolver
    }
    
    init() {
        let serviceAssembly = ServiceAssembly()
        let factoryAssembly = FactoryAssembly()
        let configuratorAssembly = ConfiguratorAssembly()
        
        assembler = Assembler([
            serviceAssembly,
            factoryAssembly,
            configuratorAssembly
        ])
    }
    
    func start() -> Configurator {
        resolver.resolve(PostListConfigurator.self)!
    }
}
