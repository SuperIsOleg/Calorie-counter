import SwiftUI

struct CalorieProgressView: View {
    let totalCalories: Double
    let dailyGoal: Double
    
    var progress: Double {
        min(totalCalories / dailyGoal, 1.0)
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.3), lineWidth: 20)
                .frame(width: 150, height: 150)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(Color.green, style: StrokeStyle(lineWidth: 20, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .frame(width: 150, height: 150)
                .animation(.easeInOut, value: progress)
            
            VStack {
                Text(String(format: "%.1f", totalCalories))
                    .font(.title)
                    .fontWeight(.bold)
                Text("of \(dailyGoal, specifier: "%.1f")")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
}
