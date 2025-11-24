import SwiftUI

struct MainButtonStyle: ButtonStyle {
    private var backgroundColor: Color {
        .blue
    }
    
    private func foregroundColor(_ configuration: Configuration) -> Color {
        return configuration.isPressed ? .white.opacity(0.5) : .white
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(foregroundColor(configuration))
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(backgroundColor)
            .clipShape(Capsule())
            .minimumScaleFactor(0.8)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
}

extension ButtonStyle where Self == MainButtonStyle {
    static var main: Self {
        MainButtonStyle()
    }
}
