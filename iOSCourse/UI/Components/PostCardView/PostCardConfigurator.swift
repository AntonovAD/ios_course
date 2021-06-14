//

import Foundation
import UIKit

/*class PostCardConfigurator: Configurator {
    //private let postProvider: PostProviderProtocol
    private let tagsCollectionDataProviderFactory: CollectionDataProviderFactory<TagViewPresenter>
    private let cellPresenterFactory: TagViewPresenterFactoryProtocol
    
    init(
        //postProvider: PostProviderProtocol,
        tagsCollectionDataProviderFactory: CollectionDataProviderFactory<TagViewPresenter>,
        cellPresenterFactory: TagViewPresenterFactoryProtocol
    ) {
        //self.postProvider = postProvider
        self.tagsCollectionDataProviderFactory = tagsCollectionDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
    }
    
    func configure() -> UITableViewCell {
        let tagsCollectionDataProvider = CollectionDataProviderFactory.createDataProvider()
        
        /*let interactor = PostListInteractor(
            postProvider: postProvider,
            cellPresenterFactory: cellPresenterFactory
        )*/
        let presenter = TagViewPresenter(
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
}*/
