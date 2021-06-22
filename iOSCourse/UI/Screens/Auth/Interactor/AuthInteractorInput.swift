//

import Foundation

protocol AuthInteractorInput: AnyObject {
    func authUser(login: String, password: String)
}
