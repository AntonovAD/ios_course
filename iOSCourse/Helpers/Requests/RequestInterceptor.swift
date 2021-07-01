//

import Foundation

protocol RequestInterceptor {
    func intercept(_ urlRequest: URLRequest) -> URLRequest
}
