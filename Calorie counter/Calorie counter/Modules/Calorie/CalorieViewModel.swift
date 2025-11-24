import Foundation
import Combine
import SwiftData

final class CalorieViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var calories: String = ""
    @Published var presentingAlert: Bool = false
    
    private(set) var imageData: Data? = nil
    private let router: CalorieRouting
    private(set) var viewType: CalorieViewType
    private(set) var selectedCalorieModel: CalorieModel?
    private(set) var alertType: BaseAlertType = .raw(title: "", subTitle: "")
    
    init(router: CalorieRouting) {
        self.router = router
        self.viewType = .create
        self.selectedCalorieModel = nil
    }
    
    init(router: CalorieRouting, selectedCalorieModel: CalorieModel) {
        self.router = router
        self.viewType = .edit
        self.selectedCalorieModel = selectedCalorieModel
        
        self.imageData = selectedCalorieModel.image
        self.name = selectedCalorieModel.title
        self.calories = String(selectedCalorieModel.calories)
    }
    
    func popToBack() {
        router.popToBack()
    }
    
    func getTitle() -> String {
        switch viewType {
        case .create:
            return "Add a calorie"
        case .edit:
            return "Edit a calorie"
        }
    }
    
    func getButtonTitle() -> String {
        switch viewType {
        case .create:
            return "Add a calorie"
        case .edit:
            return "Update a calorie"
        }
    }
    
    func asignImageData(_ data: Data?) {
        imageData = data
    }
    
    func tapOnDeleteButton() {
        alertType = .delete(title: "Delete calorie", subTitle: "Do you want delete calorie?")
        presentingAlert = true
    }
    
    func deleteSelectedCalorie(context: ModelContext) {
        if let selectedCalorieModel {
            context.delete(selectedCalorieModel)
        }
    }
    
    func handleMainButtonAction(existingNames: [String], context: ModelContext) {
        switch viewType {
        case .create:
            guard validateUniqName(existingNames: existingNames) else { return }
            createNewCalorie { context.insert($0) }
            popToBack()
            
        case .edit:
            tapOnUpdate()
            try? context.save()
            popToBack()
        }
    }
    
    private func createNewCalorie(onSave: (CalorieModel) -> Void) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard !trimmedName.isEmpty else {
            alertType = .raw(title: String(localized: "Error"), subTitle: String(localized: "Please, add a name"))
            presentingAlert = true
            return
        }
        
        guard !calories.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            alertType = .raw(title: String(localized: "Error"), subTitle: String(localized: "Please, add a calories"))
            presentingAlert = true
            return
        }
        
        let calorieModel = CalorieModel(title: trimmedName, calories: Double(calories) ?? 0, image: imageData)
        
        onSave(calorieModel)
    }
    
    private func tapOnUpdate() {
        selectedCalorieModel?.title = name
        selectedCalorieModel?.calories = Double(calories) ?? 0
        selectedCalorieModel?.image = imageData
    }
    
    private func validateUniqName(existingNames: [String]) -> Bool {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if viewType == .create && existingNames.contains(trimmedName) {
            alertType = .raw(
                title: "Error",
                subTitle: "Calorie with this name already exists"
            )
            presentingAlert = true
            return false
        }
        
        return true
    }
}
