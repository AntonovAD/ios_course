//

import Foundation
import UIKit

class PostListConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let postListTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        postListTableDataProviderFactory: TableDataProviderFactoryProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.postListTableDataProviderFactory = postListTableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
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
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
