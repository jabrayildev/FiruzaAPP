import SwiftUI

struct StartTimePickerSheet: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Binding var selectedDate: Date
    
    let onConfirm: () -> Void
    
    @State private var tempDate = Date()
    
    var body: some View {
        
        NavigationStack {
            
            VStack(spacing: 0) {
                
                DatePicker(
                    "",
                    selection: $tempDate,
                    displayedComponents: [.date, .hourAndMinute]
                )
                .datePickerStyle(.wheel)
                .labelsHidden()
                .colorScheme(.dark)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                
                ToolbarItem(placement: .topBarLeading) {
                    
                    Button("Cancel") {
                        
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    
                    Button("Готово") {
                        
                        selectedDate = tempDate
                        
                        onConfirm()
                        
                        dismiss()
                    }
                }
            }
        }
    }
}
