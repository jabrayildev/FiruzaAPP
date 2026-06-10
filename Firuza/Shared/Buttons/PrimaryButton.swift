import SwiftUI

struct PrimaryButton: View {
    
    let title: String
    
    let action: () -> Void
    
    var isDisabled: Bool = false
    
    var body: some View {
        
        Button(action: {
            if !isDisabled {
                action()
            }
        }) {
            
            Text(title)
                .font(AppFonts.cardTitle2())
                .foregroundColor(AppColors.white)
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(isDisabled ? AppColors.primary.opacity(0.4) : AppColors.primary)
                .cornerRadius(50)
                .animation(.easeOut, value: isDisabled)
        }
        .disabled(isDisabled)
        .accessibilityLabel(title)
    }
}
