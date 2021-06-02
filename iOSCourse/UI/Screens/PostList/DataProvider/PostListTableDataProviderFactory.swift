//

import Foundation

protocol PostListTableDataProviderFactoryProtocol {
    func createDataProvider() -> PostListTableDataProvider
}

class PostListTableDataProviderFactory: PostListTableDataProviderFactoryProtocol {
    func createDataProvider() -> PostListTableDataProvider {
        return PostListTableDataProvider()
    }
}
