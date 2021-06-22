//

import Foundation

protocol AuthScreenViewControllerOutput: AnyObject, ViewOutput {
    func didSelectSubmitButton(login: String, password: String)
}
