//

import Foundation
import UIKit

struct PostScreenConfiguratorData: RouterData {
    let post: Post
}

protocol PostScreenConfiguratorInput {
    func configure(
        router: RouterProtocol?,
        data: PostScreenConfiguratorData?
    ) -> UIViewController
}
