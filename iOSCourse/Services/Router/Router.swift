//

import Foundation
import UIKit

enum RoutePath {
    case auth
    case postList
    case post
}

enum NavigationMode {
    case normal
    case present
}

typealias RouteConfig = (
    data: Any?,
    from: RoutePath?
)

protocol RouterProtocol {
    func setWindow(_ window: UIWindow?) -> Self
    func asRoot(_ routePath: RoutePath) -> Self
    
    func push(_ routePath: RoutePath, mode: NavigationMode, config: RouteConfig?)
    func replace(_ routePath: RoutePath, config: RouteConfig?)
}

/*extension RouterProtocol {
    func push(_ routePath: RoutePath) {
        push(routePath, mode: .normal)
    }
}*/

class Router: RouterProtocol {
    private weak var window: UIWindow?
    private var navigationController: UINavigationController?
    
    private let authScreen: AuthScreenConfigurator
    private let postListScreen: PostListScreenConfigurator
    private let postScreen: PostScreenConfigurator
    
    private let userProvider: UserProviderProtocol
    
    init(
        authScreen: AuthScreenConfigurator,
        postListScreen: PostListScreenConfigurator,
        postScreen: PostScreenConfigurator,
        
        userProvider: UserProviderProtocol
    ) {
        self.authScreen = authScreen
        self.postListScreen = postListScreen
        self.postScreen = postScreen
        
        self.userProvider = userProvider
    }
    
    func setWindow(_ window: UIWindow?) -> Self {
        self.window = window
        return self
    }
    
    func asRoot(_ routePath: RoutePath) -> Self {
        self.navigationController = Navigator(rootViewController: screen(by: routePath, with: nil))
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
        return self
    }
    
    func push(_ routePath: RoutePath, mode: NavigationMode, config: RouteConfig?) {
        var nextViewController: UIViewController {
            if userIsLogin() {
                return screen(by: routePath, with: config?.data)
            } else {
                return screen(by: .auth, with: nil)
            }
        }
        
        switch mode {
        case .normal:
            navigationController?.pushViewController(nextViewController, animated: true)
        case .present:
            navigationController?.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    func replace(_ routePath: RoutePath, config: RouteConfig?) {
        var nextViewController: UIViewController {
            if userIsLogin() {
                return screen(by: routePath, with: config?.data)
            } else {
                return screen(by: .auth, with: nil)
            }
        }
        
        navigationController?.setViewControllers([nextViewController], animated: true)
    }
}

private extension Router {
    func screen(by routePath: RoutePath, with data: Any?) -> UIViewController {
        switch routePath {
            
        case .auth:
            return authScreen.configure(router: self)
            
        case .postList:
            return postListScreen.configure(router: self)
            
        case .post:
            let data: PostScreenConfiguratorData? = data as? PostScreenConfiguratorData
            return postScreen.configure(router: self, data: data)
            
        }
    }
    
    func userIsLogin() -> Bool {
        return true
    }
}
