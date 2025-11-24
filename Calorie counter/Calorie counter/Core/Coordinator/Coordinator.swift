import SwiftUI
import Combine

enum RootView {
    case home
}

@MainActor
final class Coordinator: ObservableObject {
    @Published var path: [NavigationPathItem] = []
    @Published var fullScreenCover: FullScreenCoverItem?
    @Published var rootView: RootView = .home
    
    func pushTo(id: String, destination: @escaping () -> some View) {
        let item = NavigationPathItem(id: id) {
            AnyView(destination())
        }
        item.isShown = true
        path.append(item)
    }
    
    func replaceStack(with id: String, destination: @escaping () -> some View) {
        path.removeAll()
        let item = NavigationPathItem(id: id) {
            AnyView(destination())
        }
        item.isShown = true
        path.append(item)
    }
    
    func popToRoot() {
        path.removeAll()
    }
    
    func popTo(id: String) {
        guard let index = path.firstIndex(where: { $0.id == id }),
              !path.isEmpty, index < path.count else { return }
        path.removeLast(path.count - (index + 1))
    }
    
    func popToBack() {
        path.removeLast()
    }
    
    func resetNavPath() {
        popToRoot()
    }
    
    func presentFullScreenCover(id: String, @ViewBuilder content: @escaping () -> some View) {
        fullScreenCover = FullScreenCoverItem(id: id, content: AnyView(content()))
    }
    
    func dismissFullScreenCover() {
        fullScreenCover = nil
    }
    
    func setRootView(_ rootView: RootView) {
        path.removeAll()
        self.rootView = rootView
    }
}
