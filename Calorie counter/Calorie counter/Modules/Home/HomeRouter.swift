import Foundation

protocol HomeRouting: AnyObject {
    func pushToAddCalories()
    func pushToEditCalories(_ model: CalorieModel)
}

final class HomeRouter: HomeRouting {
    private weak var coordinator: Coordinator?
    
    init(coordinator: Coordinator? = nil) {
        self.coordinator = coordinator
    }
    
    func pushToAddCalories() {
        coordinator?.pushTo(id: CalorieView.navigationID) {
            CalorieView(
                viewModel: .init(
                    router: CalorieRouter(
                        coordinator: self.coordinator
                    )
                )
            )
        }
    }
    
    func pushToEditCalories(_ model: CalorieModel) {
        coordinator?.pushTo(id: CalorieView.navigationID) {
            CalorieView(
                viewModel: .init(
                    router: CalorieRouter(
                        coordinator: self.coordinator
                    ),
                    selectedCalorieModel: model
                )
            )
        }
    }
}
