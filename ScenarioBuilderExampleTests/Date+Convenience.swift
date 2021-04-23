import Foundation

extension Date {

    init(year: Int, month: Int, day: Int) {
        self = DateComponents(calendar: .current, year: year, month: month, day: day).date!
    }
}
