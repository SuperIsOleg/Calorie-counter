import SwiftUI

struct BaseTextField<Value: Hashable>: View {
    @Binding var text: String
    @FocusState.Binding var focused: Value?
    
    let equals: Value
    let title: String
    let keyboardType: UIKeyboardType
    
    var borderColor: Color {
        if focused == equals {
            return .blue
        } else {
            return .clear
        }
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 12, weight: .regular))
            
            HStack {
                TextField("", text: $text)
                    .keyboardType(keyboardType)
                    .focused($focused, equals: equals)
                
                if !text.isEmpty && focused == equals {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
            .padding(12)
            .frame(maxWidth: .infinity, minHeight: 44, maxHeight: 44)
            .background(.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(borderColor, lineWidth: 2)
            )
        }
        .animation(.default, value: focused == equals)
    }
}

