import SwiftUI

struct HomeView: View {
    
    @ObservedObject var fastingViewModel: FastingRingViewModel
    
    @State private var showStartPicker = false
    
    @StateObject private var announcementVM = HomeAnnouncementViewModel()
    
    var body: some View {
        ZStack {
            
            AppBackground()
            
            VStack (spacing: Layout.cardSpacing) {
                
                HeaderView(
                    selectedPlan: $fastingViewModel.selectedPlan
                )
                
                Text("Окно голодания")
                    .padding(.top, Layout.sectionSpacing)
                    .font(AppFonts.largeTitle())
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Уровень инсулина начинает снижаться")
                    .padding(.top, Layout.cardSpacing)
                    .font(AppFonts.body2())
                    .foregroundColor(AppColors.textPrimary)
                
                FastingRingView(
                    viewModel: fastingViewModel
                )
                    .padding(.top, 32)
                
                HStack(spacing: 16) {
                    
                    Button {
                        showStartPicker = true
                    } label: {
                        
                        FastingInfoCard(
                            title: "Начало",
                            icon: "add2",
                            time: fastingViewModel.startTimeText,
                            backgroundColor: AppColors.card1
                        )
                        
                    }
                    .sheet(isPresented: $showStartPicker) {
                        
                        StartTimePickerSheet(
                            selectedDate: Binding(
                                get: { fastingViewModel.startDate },
                                set: { newValue in
                                    fastingViewModel.applyStartDateChange(newValue)
                                }
                            ),
                            onConfirm: {
                                if fastingViewModel.isFastingActive {
                                    fastingViewModel.restartTimer()
                                }
                            }
                        )
                    }
                    
                    FastingInfoCard(
                        title: "Конец",
                        icon: "stop.fill",
                        time: fastingViewModel.endTimeText,
                        backgroundColor: AppColors.card2
                        
                    )
                }
                .padding(.top, 16)
                .padding(.horizontal, 24)
                
                PrimaryButton(
                    title: fastingViewModel.isFastingActive
                        ? "Остановить голодание"
                        : "Начать голодание"
                ) {
                    fastingViewModel.toggleFasting()
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 24)
                
                AnnouncementCard(
                    title: announcementVM.title,
                    message: announcementVM.message
                )

                
                Spacer()
            }
            .padding(.top, 20)
            .padding(.horizontal, Layout.screenHorizontalPadding)
            .onAppear {
                announcementVM.load()
                fastingViewModel.onAppStart()
            }
        }
    }
}


