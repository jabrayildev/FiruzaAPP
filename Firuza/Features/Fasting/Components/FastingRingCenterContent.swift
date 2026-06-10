import SwiftUI

struct FastingRingCenterContent: View {
    
    let title: String
    
    let remainingTime: String
    
    let percentageText: String
    
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            VStack(spacing: 12) {
                
                Text(title)
                    .font(AppFonts.body1())
                    .foregroundColor(AppColors.textPrimary)
                
                Text(remainingTime)
                    .font(AppFonts.timeTitle())
                    .foregroundColor(AppColors.textPrimary)
                
                Rectangle()
                    .fill(AppColors.textPrimary.opacity(0.3))
                    .frame(width: 120, height: 1)
                
                Text(percentageText)
                    .font(AppFonts.body1())
                    .foregroundColor(AppColors.primary)
            }
        }
    }
}
