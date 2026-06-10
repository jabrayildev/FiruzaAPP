import SwiftUI

struct HeaderView: View {
    
    @Binding var selectedPlan: FastingPlan
    
    var body: some View {
        HStack(spacing: 16) {
            
            HeaderValueCard(
                selectedPlan: $selectedPlan
            )
            
            Spacer()
            
            HeaderRightActionsView()
        }
    }
}
