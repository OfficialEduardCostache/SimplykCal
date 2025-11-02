//
//  Utility.swift
//  SimplykCal
//
//  Created by Eduard Costache on 29/05/2025.
//

import SwiftUI
import Combine

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct DateFormattingUtil{
    static func formattedTime(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale.current // respects user 12/24h preference
        return formatter.string(from: date)
    }
}

struct DateUtility {
    let year: Int

    /// Returns an array of first-of-month Date objects for this utility’s year.
    func months(firstMonth: Date) -> [Date] {
        var months: [Date] = []
        var cal = Calendar.current
        cal.firstWeekday = 2   // Monday = 2
        
        // Determine start (month after firstMonth) and end (current month)
        let startComps = cal.dateComponents([.year, .month], from: firstMonth)
        let now = Date()
        let endComps = cal.dateComponents([.year, .month], from: now)
        
        var year = startComps.year!
        var month = startComps.month! + 1
        
        // Iterate from month after firstMonth through current month (inclusive)
        while year < endComps.year! || (year == endComps.year! && month <= endComps.month!) {
            if let d = cal.date(from: DateComponents(year: year, month: month, day: 1)) {
                months.append(d)
                month += 1
                if month > 12 {
                    month = 1
                    year += 1
                }
            }
        }
        
        return months
    }

    /// Returns (1 = Monday, 2 = Tuesday, … 7 = Sunday) for the first‐day‐of-given Month.
    func firstWeekday(of monthDate: Date) -> Int {
        var cal = Calendar.current
        cal.firstWeekday = 2 // start week on Monday
        let comps = cal.dateComponents([.year, .month], from: monthDate)
        let firstOfMonth = cal.date(from: comps)!
        let raw = cal.component(.weekday, from: firstOfMonth)
        // raw: 1 = Sunday, 2 = Monday, …
        // shift so Monday=1, … Sunday=7
        return (raw == 1 ? 7 : raw - 1)
    }

    /// How many days are in that month?
    func daysInMonth(of monthDate: Date) -> Int {
        let cal = Calendar.current
        let range = cal.range(of: .day, in: .month, for: monthDate)!
        return range.count
    }
    
    /// Returns the current day in the Sunday, 28 May format
    static func formattedToday() -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, d MMMM"
            return formatter.string(from: Date())
        }
}
