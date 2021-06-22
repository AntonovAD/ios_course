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

protocol RouterProtocol {
    func push(_ routePath: RoutePath, mode: NavigationMode)
    func setWindow(_ window: UIWindow?) -> Self
    func asRoot(_ routePath: RoutePath) -> Self
}

extension RouterProtocol {
    func push(_ routePath: RoutePath) {
        push(routePath, mode: .normal)
    }
}

class Router: RouterProtocol {
    private weak var window: UIWindow?
    private var navigationController: UINavigationController?
    
    private let authScreen: Configurator
    private let postListScreen: Configurator
    private let postScreen: Configurator
    
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
    
    func setWindow(_ window: UIWindow?) -> Self {
        self.window = window
        return self
    }
    
    func asRoot(_ routePath: RoutePath) -> Self {
        self.navigationController = navigator(by: routePath)
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
        return self
    }
    
    func push(_ routePath: RoutePath, mode: NavigationMode) {
        var nextViewController: UIViewController {
            if userIsLogin() {
                return view(by: routePath)
            } else {
                return view(by: .auth)
            }
        }
        
        switch mode {
        case .normal:
            navigationController?.pushViewController(nextViewController, animated: true)
        case .present:
            navigationController?.present(nextViewController, animated: true, completion: nil)
        }
    }
    
    private func screen(by routePath: RoutePath) -> (navigator: UINavigationController, view: UIViewController) {
        switch routePath {
        case .auth:
            return authScreen.configure(router: self)
        case .postList:
            return postListScreen.configure(router: self)
        case .post:
            return postScreen.configure(router: self)
        }
    }
    
    private func navigator(by routePath: RoutePath) -> UINavigationController {
        return screen(by: routePath).navigator
    }
    
    private func view(by routePath: RoutePath) -> UIViewController {
        return screen(by: routePath).view
    }
    
    private func userIsLogin() -> Bool {
        return true
    }
}
