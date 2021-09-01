import Foundation

extension String {

    func getFormattedDate(fromFormat format: String, toNewFormat newFormat: String) -> String? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = format
        if let date = dateFormatterGet.date(from: self) {
            dateFormatterGet.dateFormat = newFormat
            return dateFormatterGet.string(from: date)
        } else {
          return nil
        }
    }
    
    func getFormattedToDate(fromFormat format: String) -> Date? {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.locale = Locale(identifier: "en_US_POSIX")
        dateFormatterGet.dateFormat = format
        return dateFormatterGet.date(from: self)
    }
}
