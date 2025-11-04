//
//  SKDatePickerSheet.swift
//  SimplykCal
//
//  Created by Eduard Costache on 03/11/2025.
//
import SwiftUI
import Foundation

struct SKDatePickerSheet: View {
    @Binding var date: Date
    let mode: SKDatePickerMode
    
    // Local wheels
    @State private var day: Int
    @State private var month: Int
    @State private var year: Int
    
    @State private var simpleDay: Date
    @State private var hour: Int
    @State private var mins: Int
    
    private let calendar = Calendar.current
    private let monthNames = Calendar.current.monthSymbols
    
    // Bounds: now-16 down to (now-16)-100
    private var currentYear: Int { calendar.component(.year, from: .now) }
    private var upperYear: Int { currentYear - 16 }
    private var lowerYear: Int { upperYear - 100 }
    
    // Init from the binding
    init(date: Binding<Date>, mode: SKDatePickerMode) {
        _date = date
        self.mode = mode
        let comps = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute], from: date.wrappedValue)
        _day   = State(initialValue: comps.day ?? 1)
        _month = State(initialValue: comps.month ?? 1)
        _year  = State(initialValue: min(max(comps.year ?? 2000, (Calendar.current.component(.year, from: .now) - 16) - 100),
                                         Calendar.current.component(.year, from: .now) - 16))
        
        _simpleDay = State(initialValue: Calendar.current.startOfDay(for: date.wrappedValue))
        _hour  = State(initialValue: comps.hour ?? 12)
        _mins  = State(initialValue: comps.minute ?? 1)
    }
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            
            if mode == .simple{
                HStack{
                    Picker("Day", selection: $simpleDay) {
                        ForEach(datesAroundToday, id: \.self) { d in
                            Text(DateFormattingUtil.formatShort(date: d)).tag(d)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    HStack(spacing: 0){
                        Picker("Hour", selection: $hour) {
                            ForEach(1...23, id: \.self) { d in
                                Text(d < 10 ? "0\(d)" : "\(d)").tag(d)
                            }
                        }
                        .pickerStyle(.wheel)

                        Text(":")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                        
                        Picker("Minutes", selection: $mins) {
                            ForEach(1...59, id: \.self) { d in
                                Text(d < 10 ? "0\(d)" : "\(d)").tag(d)
                            }
                        }
                        .pickerStyle(.wheel)
                    }
                }
                .onChange(of: simpleDay, { _, _ in
                    syncSimpleToBinding()
                })
                .onChange(of: hour) { _, _ in
                    syncSimpleToBinding()
                }
                .onChange(of: mins) { _, _ in
                    syncSimpleToBinding()
                }
            }
            else if mode == .complex{
                HStack {
                    // Day
                    Picker("Day", selection: $day) {
                        ForEach(validDaysInMonth, id: \.self) { d in
                            Text("\(d)").tag(d)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    // Month (names)
                    Picker("Month", selection: $month) {
                        ForEach(1...12, id: \.self) { m in
                            Text(monthNames[m - 1]).tag(m)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                    
                    // Year (bounded)
                    Picker("Year", selection: $year) {
                        ForEach(lowerYear...upperYear, id: \.self) { y in
                            Text(String(y)).tag(y)
                        }
                    }
                    .pickerStyle(.wheel)
                    .frame(maxWidth: .infinity)
                }
                .onAppear {
                    // Make sure the initial wheels respect bounds & valid days
                    clampYearIntoBounds()
                    clampDayIfNeeded()
                    syncToBinding()
                }
                .onChange(of: month) { _, _ in clampDayIfNeeded(); syncToBinding() }
                .onChange(of: year)  { _, _ in clampYearIntoBounds(); clampDayIfNeeded(); syncToBinding() }
                .onChange(of: day)   { _, _ in syncToBinding() }
            }
        }
    }
    
    private var validDaysInMonth: [Int] {
        let comps = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: comps),
              let range = calendar.range(of: .day, in: .month, for: date)
        else { return Array(1...28) }
        return Array(range)
    }
    
    private var datesAroundToday: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let range = -7...7
        
        return range.compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: today)
        }
    }
    
    private func clampDayIfNeeded() {
        let maxDay = validDaysInMonth.last ?? 28
        if day > maxDay { day = maxDay }
        if day < 1 { day = 1 }
    }
    
    private func clampYearIntoBounds() {
        if year > upperYear { year = upperYear }
        if year < lowerYear { year = lowerYear }
    }
    
    private func syncToBinding() {
        let comps = DateComponents(year: year, month: month, day: day, hour: hour, minute: mins)
        if let newDate = calendar.date(from: comps) {
            date = newDate
        }
    }
    
    private func syncSimpleToBinding() {
        let cal = calendar
        let comps = cal.dateComponents([.year, .month, .day], from: simpleDay)
        var final = cal.date(from: comps) ?? .now
        final = cal.date(bySettingHour: hour, minute: mins, second: 0, of: final) ?? final
        date = final
    }
}

enum SKDatePickerMode{
    case simple, complex
}

#Preview {
    @Previewable @State var date: Date = Date.now
    
    VStack{
        SKDatePickerSheet(date: $date, mode: .simple)
        SKDatePickerSheet(date: $date, mode: .complex)
    }
}
