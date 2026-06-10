import SwiftUI

struct FastingRingView: View {
    
    @ObservedObject var viewModel: FastingRingViewModel
    
    var body: some View {
        
        ZStack {
            
            // Background Ring
            
            Circle()
                .stroke(
                    AppColors.circle,
                    lineWidth: AppLayout.ringLineWidth
                )
                .frame(
                    width: AppLayout.ringSize,
                    height: AppLayout.ringSize
                )
            
            // Progress Ring
            
            Circle()
                .trim(from: 0, to: viewModel.progress)
                .stroke(
                    AppColors.primary,
                    style: StrokeStyle(
                        lineWidth: AppLayout.ringLineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .frame(
                    width: AppLayout.ringSize,
                    height: AppLayout.ringSize
                )
            
            // Center Content
            
            FastingRingCenterContent(
                title: viewModel.titleText,
                remainingTime: viewModel.remainingTime,
                percentageText: viewModel.percentageText
            ) {
                
                viewModel.toggleDisplayMode()
            }
            
            // Markers
            
            GeometryReader { geometry in
                
                let size = AppLayout.ringSize
                
                let center = size / 2
                
                let radius = AppLayout.ringSize / 2
                
                let markerOffset: CGFloat = 0
                
                ForEach(viewModel.availableMarkers) { marker in
                    
                    let angle =
                    Angle.degrees(
                        (Double(marker.hour)
                         / Double(viewModel.totalPlanHours))
                        * 360
                        - 90
                    )
                    
                    let x =
                    center
                    + cos(angle.radians)
                    * (radius + markerOffset)
                    
                    let y =
                    center
                    + sin(angle.radians)
                    * (radius + markerOffset)
                    
                    FastingRingMarker(
                        marker: marker,
                        isCompleted: viewModel.markerIsCompleted(
                            hour: marker.hour
                        )
                    ) {
                        
                        viewModel.selectedMarker = marker
                        
                        viewModel.showMarkerSheet = true
                    }
                    .position(x: x, y: y)
                }
            }
            .frame(
                width: AppLayout.ringSize,
                height: AppLayout.ringSize
            )
        }
        .frame(
            width: AppLayout.ringSize,
            height: AppLayout.ringSize
        )
        .sheet(isPresented: $viewModel.showMarkerSheet) {
            
            if let marker = viewModel.selectedMarker {
                
                FastingRingMarkerSheet(marker: marker)
            }
        }
    }
}
