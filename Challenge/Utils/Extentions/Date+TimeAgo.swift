import Foundation

extension Date {
    
    func timeAgoDisplay() -> String {

        let calendar = Calendar.current
        let hourAgo = calendar.date(byAdding: .hour, value: -1, to: Date())!
        let dayAgo = calendar.date(byAdding: .day, value: -1, to: Date())!
        let weekAgo = calendar.date(byAdding: .day, value: -7, to: Date())!

        if hourAgo < self {
            let diff = Calendar.current.dateComponents([.minute], from: self, to: Date()).minute ?? 0
            return "\("ago".localized) \(diff) \("minutes".localized)"
        } else if dayAgo < self {
            let diff = Calendar.current.dateComponents([.hour], from: self, to: Date()).hour ?? 0
            return "\("ago".localized) \(diff) \("hours".localized)"
        } else if weekAgo < self {
            let diff = Calendar.current.dateComponents([.day], from: self, to: Date()).day ?? 0
            return "\(diff)\("days".localized)"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.Date.onlyDate
        return dateFormatter.string(from: self)
    }
}
