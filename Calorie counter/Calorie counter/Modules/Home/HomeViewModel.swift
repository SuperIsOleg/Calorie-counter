import Combine
import SwiftData

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var presentingAlert: Bool = false
    
    private(set) var alertType: BaseAlertType = .raw(title: "", subTitle: "")
    private let router: HomeRouting
    private(set) var selectedCalorie: CalorieModel?
    private(set) var dailyGoal = 2500.0
    
    init(router: HomeRouting) {
        self.router = router
    }
    
    func pushToAddCalorie() {
        router.pushToAddCalories()
    }
    
    func pushToEditCalorie(calorie: CalorieModel) {
        router.pushToEditCalories(calorie)
    }
    
    func tapOnDeleteButton(calorie: CalorieModel) {
        selectedCalorie = calorie
        alertType = .delete(title: "Delete calorie", subTitle: "Do you want delete calorie?")
        presentingAlert = true
    }
    
    func deleteSelectedCalorie(context: ModelContext) {
        if let selectedCalorie {
            context.delete(selectedCalorie)
        }
    }
    
    func reduce(calories: [CalorieModel]) -> Double {
        calories.reduce(0) { $0 + $1.calories }
    }
}

