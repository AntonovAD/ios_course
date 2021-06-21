//

import Foundation

protocol PostMigrationDataStorage: MigrationDataStorage {
    
}

extension PostMigrationDataStorage where Self: DataStorageProtocol {
    var migrationVersion: Int {
        get {
            getValue(key: PostMigrationKeys.migrationVersion.rawValue) ?? 0
        }
        set {
            setValue(key: PostMigrationKeys.migrationVersion.rawValue, value: newValue)
        }
    }
}

extension KeyValueDataStorage: PostMigrationDataStorage {
    
}

private enum PostMigrationKeys: String {
    case migrationVersion
}
