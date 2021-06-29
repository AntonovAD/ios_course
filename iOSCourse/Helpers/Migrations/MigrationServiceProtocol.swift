//

import Foundation
import ReactiveSwift

protocol MigrationServiceProtocol {
    func migrate()
}

protocol ReactiveMigrationServiceProtocol: AnyObject {
    func migrate() -> SignalProducer<(), Never>
}
