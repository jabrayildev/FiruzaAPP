import SwiftUI

struct HeaderValueCard: View {
    
    @State private var showPicker: Bool = false
    
  //  @State private var selectedPlan: FastingPlan = .sixteen
    
    @Binding var selectedPlan: FastingPlan
    
    var body: some View {
        
        Button {
            
            showPicker = true
            
        } label: {
            
            HStack(spacing: 8) {
                
                Text(selectedPlan.rawValue)
                    .font(AppFonts.body1())
                    .foregroundColor(AppColors.textPrimary)
                
                Image("add2")
                    .renderingMode(.original)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(AppColors.background2)
            .cornerRadius(12)
        }
        .sheet(isPresented: $showPicker) {
            
            FastingPlanPickerSheet(
                selectedPlan: $selectedPlan
            )
        }
    }
}
