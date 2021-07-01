//

import Foundation

class APIInterceptor: RequestInterceptor {
    private let userProviderRealm: ReactiveUserProviderRealmProtocol
    
    init(userProviderRealm: ReactiveUserProviderRealmProtocol) {
        self.userProviderRealm = userProviderRealm
    }
    
    func intercept(_ urlRequest: URLRequest) -> URLRequest {
        let result = userProviderRealm.getUser().first()
        switch result {
        case .success(let user):
            var urlRequest = urlRequest
            urlRequest.setValue("\(user.id)", forHTTPHeaderField: "x-user-id")
            return urlRequest
        case .failure:
            return urlRequest
        case .none:
            return urlRequest
        }
    }
}
