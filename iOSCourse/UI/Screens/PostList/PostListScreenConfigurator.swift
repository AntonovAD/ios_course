//

import Foundation
import UIKit

class PostListScreenConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let postListTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    private let navigationControllerFactory: MainNavigationFactoryProtocol
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        postListTableDataProviderFactory: TableDataProviderFactoryProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol,
        navigationControllerFactory: MainNavigationFactoryProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.postListTableDataProviderFactory = postListTableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
        self.navigationControllerFactory = navigationControllerFactory
    }
    
    func configure() -> UIViewController {
        let postListTableDataProvider = postListTableDataProviderFactory.createDataProvider()
        
        let interactor = PostListInteractor(
            postProvider: postProvider,
            reactivePostProvider: reactivePostProvider,
            cellPresenterFactory: cellPresenterFactory
        )
        let presenter = PostListPresenter(
            postListTableData: postListTableDataProvider,
            interactor: interactor
        )
        let viewController = PostListViewController(
            presenter: presenter,
            postListDataProvider: postListTableDataProvider
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let navigationController = navigationControllerFactory
            .createMainNavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
