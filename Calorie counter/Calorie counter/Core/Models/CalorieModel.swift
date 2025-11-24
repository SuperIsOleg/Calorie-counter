import Foundation
import SwiftData

@Model
class CalorieModel {
    @Attribute(.externalStorage) var image: Data?
    
    var id: UUID
    var title: String
    var calories: Double
    var date: Date

    init(title: String, calories: Double, image: Data? = nil) {
        self.id = UUID()
        self.title = title
        self.calories = calories
        self.image = image
        self.date = Calendar.current.startOfDay(for: Date())
    }
}
