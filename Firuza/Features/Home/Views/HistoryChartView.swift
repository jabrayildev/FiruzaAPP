import SwiftUI

struct HistoryChartView: View {
    
    let sessions: [FastingSession]
    
    var body: some View {
        
        let data = Array(sessions.suffix(6))
        
        HStack(alignment: .bottom, spacing: 12) {
            
            ForEach(data, id: \.id) { session in
                
                VStack(spacing: 8) {
                    
                    ZStack(alignment: .bottom) {
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.12))
                            .frame(width: 36, height: 120)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(
                                session.percent < 50
                                ? Color.red
                                : Color.green
                            )
                            .frame(
                                width: 36,
                                height: max(
                                    8,
                                    120 * CGFloat(session.progress)
                                )
                            )
                        
                        Text("\(session.percent)%")
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundColor(AppColors.textPrimary)
                            .padding(.bottom, 4)
                    }
                    
                    Text(shortDate(for: session))
                        .font(.caption2)
                        .foregroundColor(AppColors.textPrimary)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 4)
    }
}

// MARK: - Date Formatter

extension HistoryChartView {
    
    private func shortDate(for session: FastingSession) -> String {
        
        let calendar = Calendar.current
        
        let month = calendar.component(
            .month,
            from: session.startDate
        )
        
        let startDay = calendar.component(
            .day,
            from: session.startDate
        )
        
        let endDay = calendar.component(
            .day,
            from: session.endDate
        )
        
        let monthLetter: String
        
        switch month {
        case 1: monthLetter = "Я"
        case 2: monthLetter = "Ф"
        case 3: monthLetter = "М"
        case 4: monthLetter = "А"
        case 5: monthLetter = "М"
        case 6: monthLetter = "И"
        case 7: monthLetter = "И"
        case 8: monthLetter = "А"
        case 9: monthLetter = "С"
        case 10: monthLetter = "О"
        case 11: monthLetter = "Н"
        case 12: monthLetter = "Д"
        default: monthLetter = "-"
        }
        
        return "\(monthLetter) \(startDay)-\(endDay)"
    }
}
