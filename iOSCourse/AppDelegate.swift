//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let authScreenViewController = AuthScreenViewController()
        let postListViewController = PostListViewController()
        let postViewController = PostViewController()
        
        window = UIWindow()
        window?.rootViewController = postViewController
        window?.makeKeyAndVisible()
        
        return true
    }

}

