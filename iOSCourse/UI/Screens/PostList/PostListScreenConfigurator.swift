//

import Foundation
import UIKit

class PostListScreenConfigurator: Configurator {
    private let postProvider: PostProviderProtocol
    private let reactivePostProvider: ReactivePostProviderProtocol
    private let postListTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let cellPresenterFactory: PostCardViewPresenterFactoryProtocol
    private let userProvider: ReactiveUserProviderProtocol
    private let userProviderRealm: ReactiveUserProviderRealmProtocol
    
    init(
        postProvider: PostProviderProtocol,
        reactivePostProvider: ReactivePostProviderProtocol,
        postListTableDataProviderFactory: TableDataProviderFactoryProtocol,
        cellPresenterFactory: PostCardViewPresenterFactoryProtocol,
        userProvider: ReactiveUserProviderProtocol,
        userProviderRealm: ReactiveUserProviderRealmProtocol
    ) {
        self.postProvider = postProvider
        self.reactivePostProvider = reactivePostProvider
        self.postListTableDataProviderFactory = postListTableDataProviderFactory
        self.cellPresenterFactory = cellPresenterFactory
        self.userProvider = userProvider
        self.userProviderRealm = userProviderRealm
    }
    
    func configure(router: RouterProtocol?) -> UIViewController {
        let postListTableDataProvider = postListTableDataProviderFactory.createDataProvider()
        
        let interactor = PostListInteractor(
            postProvider: postProvider,
            reactivePostProvider: reactivePostProvider,
            cellPresenterFactory: cellPresenterFactory,
            userProvider: userProvider,
            userProviderRealm: userProviderRealm
        )
        let presenter = PostListPresenter(
            router: router,
            postListTableData: postListTableDataProvider,
            interactor: interactor
        )
        let viewController = PostListViewController(
            presenter: presenter,
            postListDataProvider: postListTableDataProvider
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}
