import Foundation
import SwiftUI

final class FastingCalculationService {
    
    func progress(
        startDate: Date,
        endDate: Date,
        currentDate: Date = Date()
    ) -> CGFloat {
        
        let total =
        endDate.timeIntervalSince(startDate)
        
        guard total > 0 else {
            return 0
        }
        
        let elapsed =
        currentDate.timeIntervalSince(startDate)
        
        return min(
            max(CGFloat(elapsed / total), 0),
            1
        )
    }
    
    func remainingTime(
        endDate: Date,
        currentDate: Date = Date()
    ) -> TimeInterval {
        
        max(
            endDate.timeIntervalSince(currentDate),
            0
        )
    }
    
    func elapsedTime(
        startDate: Date,
        currentDate: Date = Date()
    ) -> TimeInterval {
        
        max(
            currentDate.timeIntervalSince(startDate),
            0
        )
    }
}
