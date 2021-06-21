//

import Foundation
import RealmSwift

func resetMigration() {
    //try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    
    let realm = try! Realm()
    try! realm.write {
      realm.deleteAll()
    }
}
