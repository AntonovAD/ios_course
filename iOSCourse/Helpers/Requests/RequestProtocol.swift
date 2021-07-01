//

import Foundation

protocol RequestProtocol {
    associatedtype ParametersType: Encodable
    associatedtype ResponseType: Decodable
    associatedtype ErrorType: RequestErrorProtocol
    
    var url: String { get }
    var method: HTTPMethod { get }
    var parameters: ParametersType { get }
    var headers: [String: String]? { get }
    
    var encodingType: EncodingType? { get }
    var decoder: JSONDecoder? { get }
}

extension RequestProtocol {
    var headers: [String: String]? {
        return nil
    }
    
    var encodingType: EncodingType? {
        return nil
    }
    var decoder: JSONDecoder? {
        return nil
    }
}

enum HTTPMethod: String {
    case connect = "CONNECT"
    case delete = "DELETE"
    case get = "GET"
    case head = "HEAD"
    case options = "OPTIONS"
    case patch = "PATCH"
    case post = "POST"
    case put = "PUT"
    case trace = "TRACE"
}

enum EncodingType {
    case queryString(keyEncoding: KeyEncoding)
    case json(encoder: JSONEncoder)
    
    public enum KeyEncoding {
        case convertToSnakeCase
        case useDefaultKeys
    }
}

protocol RequestErrorProtocol: Error {
    init(code: Int?, data: Data?)
    init(isReachable: Bool?, data: Data?)
}
