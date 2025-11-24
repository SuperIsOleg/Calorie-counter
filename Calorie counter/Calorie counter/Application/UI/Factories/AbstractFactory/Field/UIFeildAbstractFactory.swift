import SwiftUI

protocol UIFeildAbstractFactory {
    func createBaseTextField<Value: Hashable>(
        title: String,
        text: Binding<String>,
        focused: FocusState<Value?>.Binding,
        equals: Value,
        keyboardType: UIKeyboardType
    ) -> AnyView
}
