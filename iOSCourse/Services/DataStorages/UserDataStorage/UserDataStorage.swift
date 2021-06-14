//

import Foundation

protocol UserDataStorage: AnyObject {
    var user: User { get set }
}

private enum UserDataStorageKeys: String {
    case user
}

extension UserDataStorage where Self: DataStorageProtocol {
    fileprivate func getValue<T>(key: UserDataStorageKeys) -> T? {
        let value: T? = getValue(key: key.rawValue)
        return value
    }
    
    fileprivate func setValue<T>(key: UserDataStorageKeys, value: T) {
        setValue(key: key.rawValue, value: value)
    }
}

extension UserDataStorage where Self: DataStorageProtocol {
    var user: User? {
        get {
            guard let data: Data = getValue(key: .user) else {
                return nil
            }
            
            let decoder = JSONDecoder()
            return (try? decoder.decode(User.self, from: data)) ?? nil
        }
        set {
            let encoder = JSONEncoder()
            let data = try? encoder.encode(newValue)
            setValue(key: .user, value: data)
        }
    }
}
