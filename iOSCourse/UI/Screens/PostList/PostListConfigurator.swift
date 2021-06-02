//

import Foundation
import UIKit

class PostListConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let tableDataProviderFactory: PostListTableDataProviderFactoryProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    
    init(
        postProvider: PostProviderProtocol,
        tableDataProviderFactory: PostListTableDataProviderFactoryProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    ) {
        self.postProvider = postProvider
        self.tableDataProviderFactory = tableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
    }
    
    func configure() -> UIViewController {
        let dataProvider = tableDataProviderFactory.createDataProvider()
        
        let interactor = PostListInteractor(
            postProvider: postProvider,
            cellPresenterFactory: cellPresenterFactory
        )
        let presenter = PostListPresenter(
            tableData: dataProvider,
            interactor: interactor
        )
        let viewController = PostListViewController(
            presenter: presenter,
            dataProvider: dataProvider
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let navigationController = UINavigationController(rootViewController: viewController)
        
        return navigationController
    }
}
