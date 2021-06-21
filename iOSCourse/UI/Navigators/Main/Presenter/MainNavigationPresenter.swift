//

import Foundation

class MainNavigationPresenter {
    private let interactor: MainNavigationInteractorInput
    
    weak var navigationController: MainNavigationControllerInput?
    
    init(interactor: MainNavigationInteractorInput) {
        self.interactor = interactor
    }
}

extension MainNavigationPresenter: MainNavigationInteractorOutput {
    
}

extension MainNavigationPresenter: MainNavigationControllerOutput {
    func viewIsReady() {
        
    }
}
