//

import Foundation

protocol ViewOutput {
    func viewIsReady()
}

protocol ViewSetup {
    func setup(with presenter: ViewOutput)
}
