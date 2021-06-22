//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appService: AppServiceProtocol = AppService()

    var window: UIWindow?
    var router: RouterProtocol?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        
        router = appService.start()
            .setWindow(window)
            .asRoot(.auth)
        
        return true
    }

}

