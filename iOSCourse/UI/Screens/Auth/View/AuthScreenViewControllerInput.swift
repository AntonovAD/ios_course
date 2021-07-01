//

import Foundation

protocol AuthScreenViewControllerInput: AnyObject {
    func updateTitle(_ text: String)
    func errorPulseAppTitle()
}
