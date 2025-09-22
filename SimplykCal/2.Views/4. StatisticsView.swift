import SwiftUI
import Charts
import Foundation

let userJoinedDate: Date = Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1))!
let daysInWeek: [String] = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
let hardcodedDates2024: [Date] = [
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 9))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 30))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 14))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 18))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 21))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 20))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 24))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 4))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 16))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 16))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 12))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 20))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 21))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 9))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 15))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 18))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 8))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 30))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 21))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 20))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 9))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 30))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 5))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 8))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 16))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 28))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 4))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 29))!, // leap day
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 16))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 15))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 15))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 28))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 31))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 18))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 5))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 22))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 16))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 25))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 30))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 24))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 8))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 22))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 31))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 4))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 31))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 30))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 2))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 2))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 12))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 25))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 10, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 17))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 10))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 1))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 18))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 8))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 24))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 11))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 15))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 18))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 6))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 17))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 25))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 8, day: 28))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 7))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 24))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 9, day: 20))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 13))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 14))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 3))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 11, day: 14))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 26))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 7, day: 31))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 5, day: 23))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 27))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 22))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 14))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 12, day: 9))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 25))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 29))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 6, day: 19))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 4, day: 4))!,
    Calendar.current.date(from: DateComponents(year: 2024, month: 3, day: 21))!
]


struct StatisticsView: View {
    var body: some View {
        NavigationStack{
            VStack{
                NavigationLink {
                    CustomCalendarView()
                } label: {
                    Section1()
                }
                

                HStack{
                    Section2()
                    Section3()
                }
                
                Section4()
                
                Spacer()
            }
            .background(Color("background").ignoresSafeArea(.all))
        }
        .tint(Color("text2"))
    }
}

private struct Section1: View {
    var body: some View {
        ZStack{
            // BACKGROUND
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Color("background2"))

            VStack(alignment: .trailing, spacing: 0){
                HStack{
                    // HEADER
                    Text("Weekly Summary")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    
                    Spacer()
                    
                    // ARROW
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                
                HStack(spacing: 0) {
                    ForEach(daysInWeek, id: \.self) { day in
                        VStack{
                            Text(day)
                                .font(.system(size: 14, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                
                            WeeklyStreak()
                                .opacity(day == "Thu" || day == "Fri" || day == "Sat" || day == "Sun" ? 0.1 : 1)
                        }
                        .padding(2)
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .padding(.vertical, 12)
            }
        }
        .frame(maxHeight: 110)
        .padding(.horizontal)
    }
}

private struct Section2: View {
    private let data: [TrendPoint] = [
        TrendPoint(x: -10, y: 5),
        TrendPoint(x: 0, y: 4),
        TrendPoint(x: 10, y: 4.3),
        TrendPoint(x: 20, y: 5),
        TrendPoint(x: 30, y: 3)
    ]
    
    var body: some View {
        ZStack{
            // BACKGROUND
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Color("background2"))
            
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    // HEADER
                    Text("BMR Trend")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    
                    Spacer()
                    
                    // ARROW
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                
                // LINE GRAPH
                Chart {
                    ForEach(data) { p in
                        LineMark(
                            x: .value("Index", p.x),
                            y: .value("Value", p.y)
                        )
                        .interpolationMethod(.linear)
                        .lineStyle(.init(lineWidth: 2, lineCap: .round))
                        .foregroundStyle(Color("secondary"))

                        PointMark(
                            x: .value("Index", p.x),
                            y: .value("Value", p.y)
                        )
                        .symbol(.circle)
                        .symbolSize(40)
                        .foregroundStyle(Color("secondary"))
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .chartYScale(domain: 0...10)
                .padding()
            }
        }
        .frame(height: 150)
        .padding(.leading)
    }
}

private struct Section3: View {
    private let data: [TrendPoint] = [
        TrendPoint(x: -10, y: 5),
        TrendPoint(x: 0, y: 8),
        TrendPoint(x: 10, y: 3),
        TrendPoint(x: 20, y: 7),
        TrendPoint(x: 30, y: 2)
    ]
    
    var body: some View {
        ZStack{
            // BACKGROUND
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Color("background2"))
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    // HEADER
                    Text("Weight Trend")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    
                    Spacer()
                    
                    // ARROW
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                
                // LINE GRAPH
                Chart {
                    ForEach(data) { p in
                        LineMark(
                            x: .value("Index", p.x),
                            y: .value("Value", p.y)
                        )
                        .interpolationMethod(.linear)
                        .lineStyle(.init(lineWidth: 2, lineCap: .round))
                        .foregroundStyle(Color("secondary"))

                        PointMark(
                            x: .value("Index", p.x),
                            y: .value("Value", p.y)
                        )
                        .symbol(.circle)
                        .symbolSize(40)
                        .foregroundStyle(Color("secondary"))
                    }
                }
                .chartXAxis(.hidden)
                .chartYAxis(.hidden)
                .chartYScale(domain: 0...10)
                .padding()
            }
        }
        .frame(height: 150)
        .padding(.trailing)
    }
}

private struct Section4: View {
    var body: some View {
        ZStack{
            // BACKGROUND
            RoundedRectangle(cornerSize: CGSize(width: 10, height: 10))
                .fill(Color("background2"))
            
            VStack(spacing: 0){
                HStack{
                    // HEADER
                    Text("Yearly contributions")
                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                    
                    
                    Spacer()
                    
                    // ARROW
                    Image(systemName: "chevron.right")
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                        .padding(.trailing, 10)
                        .padding(.top, 10)
                }
                
                ContributionGrid()
                    .padding(12)
            }
        }
        .frame(height: 100)
        .padding(.horizontal)
    }
}

private struct ContributionGrid: View {
    private let cell: CGFloat = 4.5
    private let spacing: CGFloat = 2
    private let corner: CGFloat = 1
    private let calendar = Calendar(identifier: .iso8601)

    private var start: Date { calendar.date(from: DateComponents(year: 2024, month: 1, day: 1))! }
    private var end: Date { calendar.date(from: DateComponents(year: 2024, month: 12, day: 31))! }

    private var weeksCount: Int {
        // Number of weekly columns needed to cover the full range (Mon‑start year; 2024 has 366 days)
        let days = calendar.dateComponents([.day], from: start, to: end).day! + 1
        return Int(ceil(Double(days) / 7.0)) // 53 columns for 2024
    }

    var body: some View {
        
        HStack(alignment: .top, spacing: spacing) {
            ForEach(0..<weeksCount, id: \.self) { col in
                VStack(spacing: spacing) {
                    ForEach(0..<7, id: \.self) { row in
                        let offset = col * 7 + row
                        let date = calendar.date(byAdding: .day, value: offset, to: start)!
                        let isMarked = hardcodedDates2024.contains(calendar.startOfDay(for: date))
                        if date <= end {
                            RoundedRectangle(cornerRadius: corner, style: .continuous)
                                .fill(isMarked ? Color("secondary") : Color("text2").opacity(0.2))
                                .frame(width: cell, height: cell)
                        } else {
                            Color.clear
                                .frame(width: cell, height: cell)
                        }
                    }
                }
            }
        }
        
    }
}

private struct CustomCalendarView: View {
    let dateUtility = DateUtility(year: 2024)

    var body: some View {
        VStack(spacing: 0) {
            // Days‐of‐week header
            Grid {
                GridRow {
                    ForEach(daysInWeek, id: \.self) { day in
                        Text(day)
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
            .background(Color("background2"))

            // Scrollable list of months
            ScrollView {
                VStack(spacing: 24) {
                    MonthView(month: userJoinedDate, minDay: Calendar.current.component(.day, from: userJoinedDate))
                    ForEach(dateUtility.months(firstMonth: userJoinedDate), id: \.self) { month in
                        MonthView(month: month)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 12)
            }
        }
        .background(
            Color("background")
        )
    }
}

/// A “mini‐calendar” for one month: shows month name + a 7×N grid of day‐cells.
private struct MonthView: View {
    let month: Date
    let minDay: Int

    init(month: Date, minDay: Int = 1) {
        self.month = month
        self.minDay = minDay
    }

    var body: some View {
        let firstWeekday: Int = DateUtility(year: 2024).firstWeekday(of: month)    // Monday = 1, … Sunday = 7
        let daysInMonth: Int = DateUtility(year: 2024).daysInMonth(of: month)
        
        // Compute how many rows are needed:
        // totalCells = daysInMonth + (firstWeekday – 1)
        // rows = ceil(totalCells / 7)
        let totalCells = daysInMonth + (firstWeekday - 1)
        let rows = Int(ceil(Double(totalCells) / 7.0))

        // --- Date helpers for each cell ---
        let cal = Calendar(identifier: .iso8601)
        let year = cal.component(.year, from: month)
        let monthNumber = cal.component(.month, from: month)
        let monthStart = cal.date(from: DateComponents(calendar: cal, year: year, month: monthNumber, day: 1))!

        VStack(alignment: .center, spacing: 8) {
            // Month name header
            let monthName = Self.monthFormatter.string(from: month)
            Text(monthName)
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .foregroundStyle(Color("text1"))

            // Actual grid of days (compute a Date per cell)
            Grid {
                ForEach(0..<rows, id: \.self) { row in
                    GridRow {
                        ForEach(0..<7, id: \.self) { col in
                            let flatIndex = row * 7 + col
                            let dayOffset = flatIndex - (firstWeekday - 1)

                            if dayOffset >= 0 && dayOffset < daysInMonth {
                                let cellDate = cal.date(byAdding: .day, value: dayOffset, to: monthStart)!
                                let dayOfMonth = cal.component(.day, from: cellDate)

                                if dayOfMonth >= minDay {
                                    ZStack {
                                        Text("\(dayOfMonth)")
                                            .frame(maxWidth: .infinity, minHeight: 32)
                                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                                            .foregroundStyle(Color("text2"))
                                        
                                        if hardcodedDates2024.contains(cellDate) {
                                            Circle()
                                                .trim(from: 0, to: Double.random(in: 0...1))
                                                .rotation(Angle(degrees: -90))
                                                .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                                                .foregroundStyle(AngularGradient(colors: [Color(hex: "FF7B00"), Color(hex: "C10000")], center: .center, startAngle: .degrees(-15), endAngle: .degrees(180)))
                                        
                                        }
                                        
                                        Circle()
                                            .stroke(style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round))
                                            .foregroundStyle(Color.black.opacity(0.2))
                                    }
                                } else {
                                    Color.clear
                                        .frame(maxWidth: .infinity, minHeight: 32)
                                }
                            } else {
                                // Empty cell
                                Color.clear
                                    .frame(maxWidth: .infinity, minHeight: 32)
                            }
                        }
                    }
                }
            }
        }
    }

    private static let monthFormatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "en_US_POSIX")
        f.dateFormat = "MMMM YYYY"
        return f
    }()
}

private struct Cell: View {
    let dayNumber: Int?
    var body: some View {
        if let n = dayNumber {
            Text("\(n)")
                .frame(maxWidth: .infinity, minHeight: 32)
        } else {
            Color.clear.frame(maxWidth: .infinity, minHeight: 32)
        }
    }
}



private struct TrendPoint: Identifiable {
    let id = UUID()
    let x: Int
    let y: Double
}

private struct WeeklyStreak: View {
    
    private let imageSize: CGFloat = 16
    
    var body: some View {
        Image("calories")
            .resizable()
            .scaledToFit()
            .frame(width: 22, height: 22)
            .foregroundStyle(Color("primary"))
    }
}

#Preview {
    StatisticsView()
}

