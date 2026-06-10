import Foundation

enum DateTimeFormatter {
    
    static func formatTime(
        _ interval: TimeInterval
    ) -> String {
        
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        
        return String(
            format: "%02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )
    }
    
    static func formatDate(
        _ date: Date
    ) -> String {
        
        let calendar = Calendar.current
        
        let formatter = Foundation.DateFormatter()
        formatter.dateFormat = "HH:mm"
        
        let time = formatter.string(from: date)
        
        if calendar.isDateInToday(date) {
            return "Сегодня, \(time)"
        }
        
        if calendar.isDateInTomorrow(date) {
            return "Завтра, \(time)"
        }
        
        if calendar.isDateInYesterday(date) {
            return "Вчера, \(time)"
        }
        
        formatter.dateFormat = "dd.MM, HH:mm"
        
        return formatter.string(from: date)
    }
}
