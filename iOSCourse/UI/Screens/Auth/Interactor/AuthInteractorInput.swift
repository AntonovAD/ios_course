//

import Foundation

protocol AuthInteractorInput: AnyObject {
    func signIn(login: String, password: String)
}
