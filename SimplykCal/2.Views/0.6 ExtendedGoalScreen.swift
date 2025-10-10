//
//  0.6 ExtendedGoalScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 07/10/2025.
//

import SwiftUI

struct ExtendedGoalScreen: View {
    @Binding var viewModel: OnboardingViewModel
    var body: some View {
        if let goal = viewModel.goal{
            switch goal {
            case .lose:
                LoseWeightExtension(viewModel: $viewModel)
            case .gain:
                GainWeightExtension(viewModel: $viewModel)
            case .maintain:
                EmptyView()
            }
        }
    }
}

private struct LoseWeightExtension: View {
    @Binding var viewModel: OnboardingViewModel
    @State var targetWeight: Double
    
    @State var testValueForSlider: Double = 0.6
    @State var textWeekKG: String = ""
    @State var textWeekBW: String = ""
    @State var textMonthKG: String = ""
    @State var textMonthBW: String = ""
    @State var bodyWeightPerWeek: Double = 0.0
    
    @State var expectedEndDate: Date = Date.now
    
    init(viewModel: Binding<OnboardingViewModel>){
        self._viewModel = viewModel
        self._targetWeight = State(initialValue: viewModel.wrappedValue.weight)
    }
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(String(format: "%.0f", viewModel.dailyCalories))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    Text("Daily Calories")
                        .font(.system(size: 14, weight: .light, design: .monospaced))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("background2"))
                )
                
                
                VStack(alignment: .leading){
                    Text(viewModel.formetDate(date: expectedEndDate))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    Text("Expected End date")
                        .font(.system(size: 14, weight: .light, design: .monospaced))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("background2"))
                )
                
            }
            .padding()
            .padding(.bottom)
            
            Text("What is your target weight?")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.horizontal)
            
            SKSlider(value: $targetWeight, range: (viewModel.weight * 0.5)...viewModel.weight, step: 0.5, unitOfMeasure: "kg")
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("background2"))
                )
                .padding(.horizontal)
                .padding(.bottom)
                .onChange(of: targetWeight) { oldValue, newValue in
                    updateExpectedEndDate()
                }
                .onAppear {
                    targetWeight = viewModel.weight
                }
            
            Text("How fast do you want to get there?")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.horizontal)
            
            Slider(value: $testValueForSlider, in: 0.25...1.0, step: 0.01)
                .tint(Color("primary"))
                .padding(.bottom)
                .padding(.horizontal)
                .onChange(of: testValueForSlider) { _, _ in
                    updateValuesForTextFields()
                    updateDailyCalories()
                    updateExpectedEndDate()
                }
            
            VStack{
                HStack{
                    Text("-")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    HStack(spacing: 2) {
                        Text("\(textWeekKG)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("kg")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(textWeekBW)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("BW%")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    Text("Per Week")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(minWidth: 100)
                }
                .padding(.horizontal)
                
                HStack{
                    Text("-")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    HStack(spacing: 2) {
                        Text("\(textMonthKG)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("kg")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(textMonthBW)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("BW%")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    Text("Per Month")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(minWidth: 100)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .onAppear(perform: {
            updateValuesForTextFields()
            updateDailyCalories()
        })
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: !viewModel.isGenderValid(), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
    
    func updateValuesForTextFields() {
        bodyWeightPerWeek = (testValueForSlider / 100) * viewModel.weight
        
        textWeekKG = String(format: "%.3f", bodyWeightPerWeek)
        textWeekBW = String(format: "%.2f", testValueForSlider)
        
        textMonthKG = String(format: "%.3f", bodyWeightPerWeek * 4)
        textMonthBW = String(format: "%.2f", testValueForSlider * 4)
    }
    
    func updateExpectedEndDate(){
        if viewModel.weight != targetWeight{
            let differenceInWeight: Double = viewModel.weight - targetWeight
            let daysToTargetWeight: Int = Int((differenceInWeight / bodyWeightPerWeek) * 7)
            
            expectedEndDate = dateByAdding(days: daysToTargetWeight, to: Date.now)
        }
    }
    
    func dateByAdding(days: Int, to date: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }
    
    func updateDailyCalories(){
        viewModel.calculateBMR()
        viewModel.calculateTDEE()
        viewModel.calculateCalorieDeficit(kgPerWeek: bodyWeightPerWeek)
    }
}

private struct GainWeightExtension: View {
    @Binding var viewModel: OnboardingViewModel
    @State var targetWeight: Double
    
    @State var testValueForSlider: Double = 0.6
    @State var textWeekKG: String = ""
    @State var textWeekBW: String = ""
    @State var textMonthKG: String = ""
    @State var textMonthBW: String = ""
    @State var bodyWeightPerWeek: Double = 0.0
    
    @State var expectedEndDate: Date = Date.now
    
    init(viewModel: Binding<OnboardingViewModel>){
        self._viewModel = viewModel
        self._targetWeight = State(initialValue: viewModel.wrappedValue.weight)
    }
    
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                    Text(String(format: "%.0f", viewModel.dailyCalories))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    Text("Daily Calories")
                        .font(.system(size: 14, weight: .light, design: .monospaced))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("background2"))
                )
                
                
                VStack(alignment: .leading){
                    Text(viewModel.formetDate(date: expectedEndDate))
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                    
                    Text("Expected End date")
                        .font(.system(size: 14, weight: .light, design: .monospaced))
                }
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color("background2"))
                )
                
            }
            .padding()
            .padding(.bottom)
            
            Text("What is your target weight?")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.horizontal)
            
            SKSlider(value: $targetWeight, range: viewModel.weight...(viewModel.weight * 1.5), step: 0.5, unitOfMeasure: "kg")
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("background2"))
                )
                .padding(.horizontal)
                .padding(.bottom)
                .onChange(of: targetWeight) { oldValue, newValue in
                    updateExpectedEndDate()
                }
                .onAppear {
                    targetWeight = viewModel.weight
                }
            
            Text("How fast do you want to get there?")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom)
                .padding(.horizontal)
            
            Slider(value: $testValueForSlider, in: 0.25...1.0, step: 0.01)
                .tint(Color("primary"))
                .padding(.bottom)
                .padding(.horizontal)
                .onChange(of: testValueForSlider) { _, _ in
                    updateValuesForTextFields()
                    updateDailyCalories()
                    updateExpectedEndDate()
                }
            
            VStack{
                HStack{
                    Text("+")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    HStack(spacing: 2) {
                        Text("\(textWeekKG)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("kg")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(textWeekBW)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("BW%")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    Text("Per Week")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(minWidth: 100)
                }
                .padding(.horizontal)
                
                HStack{
                    Text("+")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                    
                    HStack(spacing: 2) {
                        Text("\(textMonthKG)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("kg")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    HStack(spacing: 2) {
                        Text("\(textMonthBW)")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("BW%")
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color("background3"), lineWidth: 4)
                    }
                    
                    Text("Per Month")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(minWidth: 100)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .onAppear(perform: {
            updateValuesForTextFields()
            updateDailyCalories()
        })
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: !viewModel.isGenderValid(), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
    
    func updateValuesForTextFields() {
        bodyWeightPerWeek = (testValueForSlider / 100) * viewModel.weight
        
        textWeekKG = String(format: "%.3f", bodyWeightPerWeek)
        textWeekBW = String(format: "%.2f", testValueForSlider)
        
        textMonthKG = String(format: "%.3f", bodyWeightPerWeek * 4)
        textMonthBW = String(format: "%.2f", testValueForSlider * 4)
    }
    
    func updateExpectedEndDate(){
        if viewModel.weight != targetWeight{
            let differenceInWeight: Double = targetWeight - viewModel.weight
            let daysToTargetWeight: Int = Int((differenceInWeight / bodyWeightPerWeek) * 7)
            
            expectedEndDate = dateByAdding(days: daysToTargetWeight, to: Date.now)
        }
    }
    
    func dateByAdding(days: Int, to date: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }
    
    func updateDailyCalories(){
        viewModel.calculateBMR()
        viewModel.calculateTDEE()
        viewModel.calculateCalorieSurplus(kgPerWeek: bodyWeightPerWeek)
    }
}


#Preview {
    @Previewable @State var previewVM = OnboardingViewModel(mockData: true)
    ZStack {
        Color("background").ignoresSafeArea()
        ExtendedGoalScreen(viewModel: $previewVM)
    }
}
