//

import Foundation

protocol MigrationDataStorage: AnyObject {
    var migrationVersion: Int { get set }
}
