//

import Foundation
import UIKit

class PostListConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let postListTableDataProviderFactory: TableDataProviderFactory<PostCardViewPresenter>
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    
    init(
        postProvider: PostProviderProtocol,
        postListTableDataProviderFactory: TableDataProviderFactory<PostCardViewPresenter>,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    ) {
        self.postProvider = postProvider
        self.postListTableDataProviderFactory = postListTableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
    }
    
    func configure() -> UIViewController {
        let postListTableDataProvider = postListTableDataProviderFactory.createDataProvider()
        
        let interactor = PostListInteractor(
            postProvider: postProvider,
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
