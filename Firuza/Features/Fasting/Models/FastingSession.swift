import Foundation

struct FastingSession: Identifiable, Codable {
    
    let id: UUID
    let startDate: Date
    let endDate: Date
    let progress: Double
    
    var duration: TimeInterval {
        endDate.timeIntervalSince(startDate)
    }
    
    var percent: Int {
        Int(progress * 100)
    }
}
