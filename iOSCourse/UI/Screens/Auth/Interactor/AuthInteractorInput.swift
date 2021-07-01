//

import Foundation

protocol AuthInteractorInput: AnyObject {
    func signIn(login: String, password: String, fallback: Bool?)
    func autoLogin(fallback: Bool?)
}
