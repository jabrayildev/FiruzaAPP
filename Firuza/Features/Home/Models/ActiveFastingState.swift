import Foundation

struct ActiveFastingState: Codable {
    let startDate: Date
    let endDate: Date
    let isFastingActive: Bool
    let selectedPlan: FastingPlan
}
