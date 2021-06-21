//

import Foundation
import UIKit

class PostListScreenConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let postListTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    private let userProvider: ReactiveUserProviderProtocol
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        postListTableDataProviderFactory: TableDataProviderFactoryProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol,
        userProvider: ReactiveUserProviderProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.postListTableDataProviderFactory = postListTableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
        self.userProvider = userProvider
    }
    
    func configure() -> UIViewController {
        let postListTableDataProvider = postListTableDataProviderFactory.createDataProvider()
        
        let interactor = PostListInteractor(
            postProvider: postProvider,
            reactivePostProvider: reactivePostProvider,
            cellPresenterFactory: cellPresenterFactory,
            userProvider: userProvider
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
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
