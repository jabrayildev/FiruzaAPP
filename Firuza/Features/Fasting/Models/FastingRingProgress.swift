import SwiftUI

struct FastingRingProgress: View {
    
    let progress: CGFloat
    
    var body: some View {
        
        ZStack {
            
            Circle()
                .stroke(
                    AppColors.circle,
                    lineWidth: 12
                )
                .frame(width: 226, height: 226)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    AppColors.primary,
                    style: StrokeStyle(
                        lineWidth: 12,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .frame(width: 226, height: 226)
                .animation(.easeInOut, value: progress)
        }
    }
}
