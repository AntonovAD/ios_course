//

import Foundation

enum PostProviderError: Error {
    
}

protocol PostProviderProtocol {
    func requestAll(completion: @escaping (Result<[Post], PostProviderError>) -> Void)
}
