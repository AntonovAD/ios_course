//

import Foundation
import UIKit

class PostScreenConfigurator: Configurator {
    private let postTableDataProviderFactory: TableDataProviderFactoryProtocol
    private let postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol
    private let postTextPresenterFactory: PostTextViewPresenterFactoryProtocol
    private let postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol
    private let postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    
    init(
        postTableDataProviderFactory: TableDataProviderFactoryProtocol,
        postInfoPresenterFactory: PostInfoViewPresenterFactoryProtocol,
        postTextPresenterFactory: PostTextViewPresenterFactoryProtocol,
        postTagsCollectionPresenterFactory: PostTagsCollectionViewPresenterFactoryProtocol,
        postRatingPresenterFactory: PostRatingViewPresenterFactoryProtocol
    ) {
        self.postTableDataProviderFactory = postTableDataProviderFactory
        self.postInfoPresenterFactory = postInfoPresenterFactory
        self.postTextPresenterFactory = postTextPresenterFactory
        self.postTagsCollectionPresenterFactory = postTagsCollectionPresenterFactory
        self.postRatingPresenterFactory = postRatingPresenterFactory
    }
    
    func configure(router: RouterProtocol?) -> UIViewController {
        return configure(
            router: router,
            post: nil
        )
    }
}

private extension PostScreenConfigurator {
    func configure(
        router: RouterProtocol?,
        post: Post?
    ) -> UIViewController {
        let postTableDataProvider = postTableDataProviderFactory.createDataProvider()
        
        let interactor = PostInteractor(
            postInfoPresenterFactory: postInfoPresenterFactory,
            postTextPresenterFactory: postTextPresenterFactory,
            postTagsCollectionPresenterFactory: postTagsCollectionPresenterFactory,
            postRatingPresenterFactory: postRatingPresenterFactory
        )
        let presenter = PostPresenter(
            router: router,
            postTableData: postTableDataProvider,
            interactor: interactor,
            post: post
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

extension PostScreenConfigurator: PostScreenConfiguratorInput {
    func configure(
        router: RouterProtocol?,
        data: PostScreenConfiguratorData?
    ) -> UIViewController {
        return configure(
            router: router,
            post: data?.post
        )
    }
}
