//

import Foundation

protocol RequestServiceProtocol {
    func send<Request: RequestProtocol>(
        request: Request,
        completion: @escaping (Result<Request.ResponseType, Request.ErrorType>) -> Void
    )
}
