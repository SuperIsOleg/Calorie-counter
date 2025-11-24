import SwiftUI

struct EmptyStateView: View {
    let text: String
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            
            Image(systemName: "leaf.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.gray)
            
            Text(text)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.gray)
            
            Spacer()
        }
        .multilineTextAlignment(.center)
        .padding()
    }
}
