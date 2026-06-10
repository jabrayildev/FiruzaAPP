import SwiftUI

struct FastingRingMarker: View {
    
    let marker: FastingMarker
    
    let isCompleted: Bool
    
    let action: () -> Void
    
    var body: some View {
        
        Button(action: action) {
            
            Image(
                isCompleted
                ? "successActiv"
                : "successDefault"
                )
        }
                        }
                    }
