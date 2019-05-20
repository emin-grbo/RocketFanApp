import Foundation

extension DateFormatter {
    enum Precision: String {
        case hour
        case day
        case month
        case quarter
        case half
        case year

        var dateFormatString: String {
            switch self {
            case .hour:
                return "H:mm:ss dd MMM yyyy"
            case .day:
                return "dd MMM yyyy"
            case .month:
                return "MMM yyyy"
            case .quarter, .half:
                return "QQQ yyyy"
            case .year:
                return "yyyy"
            }
        }
    }

    func setPrecision(_ precision: Precision) {
        setLocalizedDateFormatFromTemplate(precision.dateFormatString)
    }
}
