import Foundation

protocol CalorieRouting: AnyObject {
    func popToBack()
}

final class CalorieRouter: CalorieRouting {
    private weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func popToBack() {
        coordinator?.popToBack()
    }
}
