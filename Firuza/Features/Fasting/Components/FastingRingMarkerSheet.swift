import SwiftUI

struct FastingRingMarkerSheet: View {
    
    let marker: FastingMarker
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            
            Capsule()
                .fill(AppColors.textPrimary.opacity(0.3))
                .frame(width: 40, height: 4)
                .frame(maxWidth: .infinity)
                .padding(.top, 8)
            
            Text(marker.title)
                .font(AppFonts.body1())
                .foregroundColor(AppColors.textPrimary)
                            
                            Text(marker.description)
                                .font(AppFonts.body1())
                                .foregroundColor(AppColors.textPrimary)
                            
                            Spacer()
                        }
                        .padding()
                        .presentationDetents([.height(260)])
                        .background(AppColors.background)
                    }
                }
