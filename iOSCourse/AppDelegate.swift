//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    private let appService: AppServiceProtocol = AppService()

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let router = appService.start()
        
        window = UIWindow()
        
        router.setWindow(window)
        router.push(.postList)
        
        return true
    }

}

