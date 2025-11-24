import SwiftUI

extension View {
    static var navigationID: String {
        String(describing: self)
    }
    
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
