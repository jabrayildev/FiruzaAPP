import SwiftUI

struct MainTabView: View {
    
    @ObservedObject var fastingVM: FastingRingViewModel
    
    var body: some View {
        TabView {
            
            HomeView(fastingViewModel: fastingVM)
                            .tabItem {
                                Label {
                                    Text("Главная")
                                } icon: {
                                    Image("timerActiv")
                                }
                            }
                            .accentColor(AppColors.primary)
            
            HistoryView(sessions: fastingVM.history)
                            .tabItem {
                                Label {
                                    Text("История")
                                } icon: {
                                    Image("historyDefault")
                                }
                            }
                            .accentColor(AppColors.primary)
        }
    }
}
