import Foundation
import Combine

final class HomeAnnouncementViewModel: ObservableObject {
    
    @Published var title = ""
    
    @Published var message = ""
    
    func load() {

        print("LOAD CALLED")

        FirestoreService.shared
            .fetchHomeAnnouncement { [weak self] announcement in

                print("ANNOUNCEMENT:", announcement as Any)

                guard let announcement else { return }

                DispatchQueue.main.async {

                    self?.title = announcement.title
                    self?.message = announcement.message
                }
            }
    }
}
