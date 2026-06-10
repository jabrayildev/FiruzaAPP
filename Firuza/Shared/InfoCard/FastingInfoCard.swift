import SwiftUI

struct FastingInfoCard: View {
    
    let title: String
    
    let icon: String
    
    let time: String
    
    let backgroundColor: Color
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            
            HStack(spacing: 6) {
                
                Text(title)
                    .font(AppFonts.body2())
                    .foregroundColor(AppColors.textPrimary)
                    
                Image(icon)
            }
            
            Text(time)
                .font(AppFonts.cardTitle())
                .foregroundColor(AppColors.textPrimary)
        }
        .padding(.vertical, 16)
        .padding(.horizontal, 12)
        .frame(maxWidth: .infinity,alignment: .leading)
        .background(backgroundColor)
        .cornerRadius(8)
    }
}
