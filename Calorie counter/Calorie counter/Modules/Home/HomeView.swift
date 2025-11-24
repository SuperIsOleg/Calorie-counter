import SwiftUI
import SwiftData

struct HomeView: View {
    @StateObject private var viewModel: HomeViewModel
    @Environment(\.modelContext) private var modelContext
    @Query private var calories: [CalorieModel] = []
    
    init(viewModel: HomeViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 16) {
            navigationView
            
            progressView
                .padding(.top, 24)
            
            if calories.isEmpty {
                EmptyStateView(text: "No calories added yet")
            } else {
                list
                    .padding(.top, 16)
            }
            
            Button("Add Calories") {
                viewModel.pushToAddCalorie()
            }
            .buttonStyle(.main)
            .padding(.horizontal, 16)
        }
        .alert(viewModel.alertType.title, isPresented: $viewModel.presentingAlert) {
            switch viewModel.alertType {
            case .delete:
                Button("Delete", role: .destructive) {
                    viewModel.deleteSelectedCalorie(context: modelContext)
                }
            default:
                Button("Ok") {
                    
                }
            }
        } message: {
            Text(viewModel.alertType.subTitle)
        }
    }
    
    var list: some View {
        List(calories) { calorie in
            Button {
                viewModel.pushToEditCalorie(calorie: calorie)
            } label: {
                HStack {
                    Text(calorie.title)
                    
                    Spacer()
                    
                    Text("Callories: \(calorie.calories, specifier: "%.1f")")
                }
                .lineLimit(1)
            }
            .swipeActions(content: {
                Button("Delete", role: .destructive) {
                    viewModel.tapOnDeleteButton(calorie: calorie)
                }
                
                Button("Edit") {
                    viewModel.pushToEditCalorie(calorie: calorie)
                }
            })
        }
        .listStyle(.plain)
    }
    
    var navigationView: some View {
        HStack {
            Text("History")
                .font(.system(size: 18, weight: .semibold))
        }
        .padding(.horizontal, 16)
    }
    
    var progressView: some View {
        CalorieProgressView(
            totalCalories: viewModel.reduce(calories: calories),
            dailyGoal: viewModel.dailyGoal
        )
    }
}

#Preview {
    HomeView(viewModel: .init(router: HomeRouter(coordinator: .init())))
}
