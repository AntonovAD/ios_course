//

import Foundation

protocol DataStorageProtocol {
    func setValue<T>(key: String, value: T)
    func getValue<T>(key: String) -> T?
}

class KeyValueDataStorage: DataStorageProtocol {
    private let userDefaults: UserDefaults
    
    init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
    }
    
    func getValue<T>(key: String) -> T? {
        userDefaults.object(forKey: key) as? T
    }
    
    func setValue<T>(key: String, value: T) {
        userDefaults.setValue(value, forKey: key)
    }
}

class FileDataStorage {
    private let fileManager: FileManager
    
    init(fileManager: FileManager) {
        self.fileManager = fileManager
    }
    
    func getValue(key: String) -> Data? {
        fileManager.contents(atPath: fileManager.temporaryDirectory.absoluteString + "/" + key)
    }
    
    func setValue(key: String, value: Data?) {
        fileManager.createFile(atPath: fileManager.temporaryDirectory.absoluteString + "/" + key, contents: value, attributes: [:])
    }
}
