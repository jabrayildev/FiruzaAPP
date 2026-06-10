import SwiftUI
import FirebaseCore

@main
struct FiruzaApp: App {
    
    @StateObject private var fastingViewModel = FastingRingViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainTabView(fastingVM: fastingViewModel)
        }
    }
}
