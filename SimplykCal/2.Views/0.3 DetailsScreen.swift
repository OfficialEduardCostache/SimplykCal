//
//  0.3 DetailsScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct DetailsScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var showBirthdayPicker: Bool = false

    var body: some View {
        VStack{
            VStack{
                VStack{
                    Image("mascot-noteTaking")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                    
                    Text("Nice to meet you \(viewModel.name)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.bottom, 6)
                    
                    Text("🧐 Tell me about yourself")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                }
                .padding()
                
                ScrollView{
                    //MARK: Birthday
                    VStack{
                        Text("Birthday")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        BirthdayContainer(birthdayAsString: viewModel.formatDate(date: viewModel.birthday))
                            .onTapGesture {
                                showBirthdayPicker = true
                            }
                    }
                    .padding(.horizontal)
                    
                    //MARK: Height
                    VStack{
                        Text("Height")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        SKSlider(value: $viewModel.height, range: viewModel.heightRange, step: 0.5, unitOfMeasure: "cm")
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("background2"))
                            )
                            
                    }
                    .padding(.horizontal)

                    //MARK: Weight
                    VStack{
                        Text("Weight")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        SKSlider(value: $viewModel.weight, range: viewModel.weightRange, step: 0.5, unitOfMeasure: "kg")
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("background2"))
                            )
                            
                    }
                    .padding(.horizontal)

                    // gender
                    VStack{
                        Text("Gender")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            SKButton(title: "Male", isSelected: viewModel.gender == .male) {
                                viewModel.gender = .male
                            }
                            SKButton(title: "Female", isSelected: viewModel.gender == .female) {
                                viewModel.gender = .female
                            }
                            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.triggerSucessfulHaptic)
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.hidden)
                
            }
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.height)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.weight)
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: !viewModel.isGenderValid(), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
                viewModel.syncTargetWeight()
                viewModel.calculateBMR()
            })
            .padding()
        }
        .sheet(isPresented: $showBirthdayPicker, onDismiss: {
            showBirthdayPicker = false
        }) {
            BirthdayPickerSheet(date: $viewModel.birthday)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

private struct BirthdayContainer: View {
    var birthdayAsString: String
    
    var body: some View {
        HStack{
            Text(birthdayAsString)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .padding(.vertical)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.down")
                .padding(.trailing)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("background2"))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("background3"), lineWidth: 4)
        }
    }
}

private struct BirthdayPickerSheet: View {
    @Binding var date: Date

    // Local wheels
    @State private var day: Int
    @State private var month: Int    // 1...12
    @State private var year: Int

    private let calendar = Calendar.current
    private let monthNames = Calendar.current.monthSymbols

    // Bounds: now-16 down to (now-16)-100
    private var currentYear: Int { calendar.component(.year, from: .now) }
    private var upperYear: Int { currentYear - 16 }
    private var lowerYear: Int { upperYear - 100 }

    // Init from the binding
    init(date: Binding<Date>) {
        _date = date
        let comps = Calendar.current.dateComponents([.day, .month, .year], from: date.wrappedValue)
        _day   = State(initialValue: comps.day ?? 1)
        _month = State(initialValue: comps.month ?? 1)
        _year  = State(initialValue: min(max(comps.year ?? 2000, (Calendar.current.component(.year, from: .now) - 16) - 100),
                                         Calendar.current.component(.year, from: .now) - 16))
    }
    
    var body: some View {
        ZStack{
            Color("background").ignoresSafeArea()
            
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
    
    private var validDaysInMonth: [Int] {
        let comps = DateComponents(year: year, month: month)
        guard let date = calendar.date(from: comps),
              let range = calendar.range(of: .day, in: .month, for: date)
        else { return Array(1...28) }
        return Array(range)
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
        let comps = DateComponents(year: year, month: month, day: day)
        if let newDate = calendar.date(from: comps) {
            date = newDate
        }
    }
}

#Preview{
    ZStack{
        Color("background").ignoresSafeArea()
        
        DetailsScreen(viewModel: .constant(OnboardingViewModel()))

    }
}
