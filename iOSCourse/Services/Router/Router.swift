//

import Foundation
import UIKit

enum Route {
    case auth
    case postList
    case post
}

protocol RouterProtocol {
    func setWindow(_ window: UIWindow?)
    func push(_ route: Route)
}

class Router: RouterProtocol {
    private let authScreen: Configurator
    private let postListScreen: Configurator
    private let postScreen: Configurator
    
    private var window: UIWindow?
    
    private let userProvider: UserProviderProtocol
    
    init(
        authScreen: Configurator,
        postListScreen: Configurator,
        postScreen: Configurator,
        userProvider: UserProviderProtocol
    ) {
        self.authScreen = authScreen
        self.postListScreen = postListScreen
        self.postScreen = postScreen
        
        self.userProvider = userProvider
    }
    
    func setWindow(_ window: UIWindow?) {
        self.window = window
    }
    
    func push(_ route: Route) {
        if userIsLogin() {
            window?.rootViewController = {
                switch route {
                case .auth:
                    return authScreen.configure()
                case .postList:
                    return postListScreen.configure()
                case .post:
                    return postScreen.configure()
                }
            }()
        } else {
            window?.rootViewController = authScreen.configure()
        }
        window?.makeKeyAndVisible()
    }
    
    private func userIsLogin() -> Bool {
        return true
    }
}
