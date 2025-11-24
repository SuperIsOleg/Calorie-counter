import SwiftUI
import Combine

struct CoordinatorView: View {
    @StateObject private var coordinator = Coordinator()

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            initialView()
                .navigationDestination(for: NavigationPathItem.self) { destination in
                    destination.destination()
                        .navigationBarBackButtonHidden(true)
                }
                .fullScreenCover(item: $coordinator.fullScreenCover) { item in
                    item.content
                        .navigationBarBackButtonHidden(true)
                }
        }
        .environmentObject(coordinator)
        .animation(.default, value: coordinator.rootView)

    }

    @ViewBuilder
    private func initialView() -> some View {
        Group {
            switch coordinator.rootView {
            case .home:
                HomeView(viewModel: .init(router: HomeRouter(coordinator: self.coordinator)))
            }
        }
        .transition(.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading)
        ))
    }
}
