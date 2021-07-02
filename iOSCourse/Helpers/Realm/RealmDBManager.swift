//

import Foundation
import RealmSwift

class RealmDBManager {
    func truncateObject(_ object: Object.Type) {
        print("RealmDBManager - truncateObject()")
        
        let realm = try! Realm()
        try! realm.write {
            realm.delete(realm.objects(object.self))
        }
    }
    
    func truncateDB() {
        print("RealmDBManager - truncateDB()")
        
        let realm = try! Realm()
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    func dropDB() {
        print("RealmDBManager - dropDB()")
        
        try! FileManager.default.removeItem(at: Realm.Configuration.defaultConfiguration.fileURL!)
    }
}
