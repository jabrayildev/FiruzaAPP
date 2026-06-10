import Foundation
import FirebaseFirestore

final class FirestoreService {
    
    static let shared = FirestoreService()
    
    private let db = Firestore.firestore()
    
    private init() { }
    
    func fetchHomeAnnouncement(
        completion: @escaping (Announcement?) -> Void
    ) {
        
        db.collection("announcements")
            .document("home")
            .addSnapshotListener { snapshot, error in
                
                guard
                let data = snapshot?.data(),
                error == nil
                else {
                    completion(nil)
                    return
                }
                
                let announcement = Announcement(title: data["title"] as? String ?? "",
                                                message: data["message"] as? String ?? ""
                )
                
                completion(announcement)
            }
    }
}
