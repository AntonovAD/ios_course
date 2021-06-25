//

import Foundation
import UIKit

class PostScreenConfigurator: Configurator {
    private let postTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol
    private let postTextPresenterFactory: PostTextViewPresenterFactoryProtocol
    private let postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    
    init(
        postTableDataProviderFactory: TableDataProviderFactoryProtocol,
        postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol,
        postTextPresenterFactory: PostTextViewPresenterFactoryProtocol,
        postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    ) {
        self.postTableDataProviderFactory = postTableDataProviderFactory
        self.postInfoPresenterFactory = postInfoPresenterFactory
        self.postTextPresenterFactory = postTextPresenterFactory
        self.postRatingPresenterFactory = postRatingPresenterFactory
    }
    
    func configure(router: RouterProtocol?) -> UIViewController {
        let postTableDataProvider = postTableDataProviderFactory.createDataProvider()
        
        let interactor = PostInteractor(
            postInfoPresenterFactory: postInfoPresenterFactory,
            postTextPresenterFactory: postTextPresenterFactory,
            postRatingPresenterFactory: postRatingPresenterFactory
        )
        let presenter = PostPresenter(
            router: router,
            postTableData: postTableDataProvider,
            interactor: interactor
        )
        let viewController = PostViewController(
            presenter: presenter,
            postDataProvider: postTableDataProvider
        )
        
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        return viewController
    }
}