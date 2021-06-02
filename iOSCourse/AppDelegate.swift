//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appService: AppServiceProtocol = AppService()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let configurator = appService.start()
        
        window = UIWindow()
        window?.rootViewController = configurator.configure()
        window?.makeKeyAndVisible()
        
        return true
    }

}

