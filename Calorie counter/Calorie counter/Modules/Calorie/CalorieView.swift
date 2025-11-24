import SwiftUI
import SwiftData

struct CalorieView: View {
    @StateObject var viewModel: CalorieViewModel
    @FocusState private var focusedField: FocusedField?
    @Query private var calories: [CalorieModel] = []
    @Environment(\.modelContext) private var modelContext
    
    let fieldFactory: UIFeildAbstractFactory = UIFieldConcreteFactory()
    
    enum FocusedField {
        case name, calories
    }
    
    var body: some View {
        VStack(spacing: 16) {
            navigationView
            
            ImageCardView(
                imageData: viewModel.imageData,
                onImageSelected: { imageData in
                    viewModel.asignImageData(imageData)
                })
            .padding(.top, 24)
            
            fieldFactory.createBaseTextField(
                title: "Name",
                text: $viewModel.name,
                focused: $focusedField,
                equals: .name,
                keyboardType: .default
            )
            
            fieldFactory.createBaseTextField(
                title: "Calories",
                text: $viewModel.calories,
                focused: $focusedField,
                equals: .calories,
                keyboardType: .decimalPad
            )
            
            Spacer()
            
            Button(viewModel.getButtonTitle()) {
                hideKeyboard()
                viewModel
                    .handleMainButtonAction(
                        existingNames: calories.map { $0.title
                        },
                        context: modelContext)
            }
            .buttonStyle(.main)
        }
        .padding(.horizontal, 16)
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
        .onTapGesture {
            hideKeyboard()
        }
        .onDisappear {
            hideKeyboard()
        }
    }
    
    var navigationView: some View {
        HStack {
            Button {
                viewModel.popToBack()
            } label: {
                Image(systemName: "arrow.left")
                    .foregroundStyle(.black)
            }
            
            Spacer()
            
            if viewModel.viewType == .edit {
                Button(role: .destructive) {
                    viewModel.tapOnDeleteButton()
                } label: {
                    Image(systemName: "trash")
                }
            }
        }
        .overlay {
            Text(viewModel.getTitle())
                .font(.system(size: 18, weight: .semibold))
        }
    }
}

#Preview {
    CalorieView(
        viewModel: .init(
            router: CalorieRouter(
                coordinator: .init()
            )
        )
    )
}
