//

import Foundation

struct APIError: RequestErrorProtocol {
    let code: Int?
    let data: [String: Any]?
    
    init(code: Int?, data: Data?) {
        self.code = code
        self.data = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
    }
    
    init(isReachable: Bool?, data: Data?) {
        self.code = 500
        self.data = try? JSONSerialization.jsonObject(with: data ?? Data(), options: []) as? [String: Any]
    }
}
