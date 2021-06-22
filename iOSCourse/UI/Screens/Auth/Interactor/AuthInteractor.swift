//

import Foundation
import ReactiveSwift

class AuthInteractor {
    private let userProvider: ReactiveUserProviderProtocol
    
    weak var presenter: AuthInteractorOutput?
    
    init(
        userProvider: ReactiveUserProviderProtocol
    ) {
        self.userProvider = userProvider
    }
}

private extension AuthInteractor {
    
}

extension AuthInteractor: AuthInteractorInput {
    
}
