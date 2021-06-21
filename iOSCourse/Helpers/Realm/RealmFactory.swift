//

import Foundation
import RealmSwift

protocol RealmFactoryProtocol {
    func createRealm() -> Result<Realm, Error>
}

class RealmFactory: RealmFactoryProtocol {
    func createRealm() -> Result<Realm, Error> {
        do {
            let realm = try Realm()
            return .success(realm)
        }
        catch {
            return .failure(error)
        }
    }
}
