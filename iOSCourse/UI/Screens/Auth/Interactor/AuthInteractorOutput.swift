//

import Foundation

protocol AuthInteractorOutput: AnyObject {
    func navigateToApp()
    
    func handleError(_ error: Error)
}
