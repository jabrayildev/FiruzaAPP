import SwiftUI

struct AnnouncementCard: View {
    
    let title: String
    
    let message: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8) {
            
            Text(title)
                .font(AppFonts.cardTitle())
                .foregroundColor(AppColors.textPrimary)
            
            Text(message)
                .font(AppFonts.cardTitle2())
                .foregroundColor(AppColors.textPrimary)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
        .padding(16)
        .background(AppColors.background2)
        .cornerRadius(12)
    }
}
