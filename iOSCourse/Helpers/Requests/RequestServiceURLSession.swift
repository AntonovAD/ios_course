//

import Foundation

class RequestServiceURLSession: RequestServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func send<Request: RequestProtocol>(
        request: Request,
        completion: @escaping (Result<Request.ResponseType, Request.ErrorType>) -> Void
    ) {
        guard let urlRequest = request.urlRequest else {
            completion(.failure(.init(code: 500, data: nil)))
            return
        }
        
        let decoder = request.decoder ?? JSONDecoder()
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                completion(
                    .failure(
                        .init(
                            code: (response as? HTTPURLResponse)?.statusCode,
                            data: nil
                        )
                    )
                )
                return
            }
            
            guard let value = try? decoder.decode(Request.ResponseType.self, from: data) else {
                completion(
                    .failure(
                        .init(
                            code: (response as? HTTPURLResponse)?.statusCode,
                            data: data
                        )
                    )
                )
                return
            }
            
            completion(.success(value))
        }
        
        task.resume()
    }
}

private extension RequestProtocol {
    var urlRequest: URLRequest? {
        guard var components = URLComponents(string: url) else {
            return nil
        }
        
        var urlRequest: URLRequest
        
        switch encodingType {
        case .json(let encoder):
            guard let url = components.url else {
                return nil
            }
            
            urlRequest = URLRequest(url: url)
            
            urlRequest.httpBody = try? encoder.encode(parameters)
            
        case .queryString(let keyEncoding):
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = keyEncoding.keyEncodingStrategy
            
            guard let data = try? encoder.encode(parameters) else {
                return nil
            }
            
            guard let dictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                return nil
            }
            
            components.queryItems = dictionary.map { key, value in URLQueryItem(name: key, value: String(describing: value)) }
            
            guard let url = components.url else {
                return nil
            }
            
            urlRequest = URLRequest(url: url)
            
        case .none:
            guard let url = components.url else {
                return nil
            }
            
            urlRequest = URLRequest(url: url)
        }
        
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}

private extension EncodingType.KeyEncoding {
    var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy {
        switch self {
        case .convertToSnakeCase: return .convertToSnakeCase
        case .useDefaultKeys: return .useDefaultKeys
        }
    }
}
