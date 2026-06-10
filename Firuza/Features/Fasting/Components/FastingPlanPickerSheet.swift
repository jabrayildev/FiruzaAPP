import SwiftUI

struct FastingPlanPickerSheet: View {
    
    @Binding var selectedPlan: FastingPlan
    
    var body: some View {
        
        VStack(spacing: 24) {
            
            Capsule()
                .fill(AppColors.textPrimary.opacity(0.3))
                .frame(width: 40, height: 4)
                .padding(.top, 8)
            
            Text("Выберите План")
                .font(AppFonts.cardTitle())
                .foregroundColor(AppColors.background)
            
            Picker("", selection: $selectedPlan) {
                
                ForEach(FastingPlan.allCases) { plan in
                    
                    Text(plan.rawValue)
                        .font(AppFonts.cardTitle2())
                        .tag(plan)
                }
            }
            .pickerStyle(.wheel)
            .frame(height: 180)
            .colorScheme(.dark)
            
            Spacer()
        }
        .presentationDetents([.height(300)])
        .background(AppColors.textPrimary)
    }
}
