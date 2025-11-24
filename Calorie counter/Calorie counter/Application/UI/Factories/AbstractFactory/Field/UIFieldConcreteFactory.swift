import SwiftUI

final class UIFieldConcreteFactory: UIFeildAbstractFactory {
    func createBaseTextField<Value: Hashable>(
        title: String,
        text: Binding<String>,
        focused: FocusState<Value?>.Binding,
        equals: Value,
        keyboardType: UIKeyboardType
    ) -> AnyView {
        AnyView (
            BaseTextField(text: text, focused: focused, equals: equals, title: title, keyboardType: keyboardType)
        )
    }
}
