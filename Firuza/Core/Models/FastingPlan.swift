import Foundation

enum FastingPlan: String, CaseIterable, Identifiable, Codable {
    
    case twelve = "12:12"
    case fourteen = "14:10"
    case sixteen = "16:8"
    case eighteen = "18:6"
    case twenty = "20:4"
    
    var id: String { rawValue }
    
    var hours: Int {
        switch self {
        case .twelve: return 12
        case .fourteen: return 14
        case .sixteen: return 16
        case .eighteen: return 18
        case .twenty: return 20
        }
    }
}
