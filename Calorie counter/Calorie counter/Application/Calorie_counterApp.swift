import SwiftUI
import SwiftData

@main
struct Calorie_counterApp: App {
    var body: some Scene {
        WindowGroup {
            CoordinatorView()
                .modelContainer(for: CalorieModel.self)
        }
    }
}
