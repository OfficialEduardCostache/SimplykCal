//
//  0.6 ExtendedGoalScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 07/10/2025.
//

import SwiftUI
import Charts

struct ExtendedGoalScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var testGoal: Goal? = .lose
    var body: some View {
        if let goal = testGoal{
            switch goal {
            case .lose:
                LoseWeightExtension(viewModel: $viewModel)
            case .maintain:
                MaintainWeightExtension(viewModel: $viewModel)
            case .gain:
                GainWeightExtension(viewModel: $viewModel)
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
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                    
                    SKTextField(text: $textWeekKG, trailingText: "kg")
                    SKTextField(text: $textWeekBW, trailingText: "%BW")
                    
                    Text("Per Week")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .frame(minWidth: 100)
                }
                .padding(.horizontal)
                
                HStack{
                    Text("-")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                    
                    SKTextField(text: $textMonthKG, trailingText: "kg")
                    SKTextField(text: $textMonthBW, trailingText: "%BW")
                    
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
        viewModel.calculateDailyCalories(kgPerWeek: bodyWeightPerWeek)
    }
}

private struct MaintainWeightExtension: View {
    @Binding var viewModel: OnboardingViewModel
    var body: some View {
        //
    }
}

private struct GainWeightExtension: View {
    @Binding var viewModel: OnboardingViewModel
    var body: some View {
        VStack{
//            HStack{
//                Text("Slower")
//                    .font(.system(size: 14, weight: .regular, design: .monospaced))
//                    .foregroundStyle(Color("text1"))
//                
//                Slider(value: $viewModel.paceForWeightGain, in: 10...100, step: 10)
//                    .tint(Color("primary"))
//                    .padding(.top, 6)
//                    .padding(.horizontal)
//                
//                Text("Faster")
//                    .font(.system(size: 14, weight: .regular, design: .monospaced))
//                    .foregroundStyle(Color("text1"))
//            }
//            .padding(.horizontal)
//            
//            VStack{
//                Text(String(format: "%.2f%%", viewModel.paceForWeightGain / 100.0))
//                    .font(.system(size: 16, weight: .regular, design: .monospaced))
//                    .foregroundStyle(Color("text1"))
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    .padding(.top, 6)
//                
//                
//                Text("of your body weight per week")
//                    .font(.system(size: 14, weight: .regular, design: .monospaced))
//                    .foregroundStyle(Color("text2"))
//                    .frame(maxWidth: .infinity, alignment: .center)
//            }
//            .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: viewModel.paceForWeightGain)
//            
//            
//            
//            Chart {
//                ForEach(viewModel.graphData) { p in
//                    LineMark(
//                        x: .value("Week", p.week),
//                        y: .value("Value", p.y)
//                    )
//                    .interpolationMethod(.linear)
//                    .lineStyle(.init(lineWidth: 2, lineCap: .round))
//                    .foregroundStyle(Color("primary"))
//                    
//                    PointMark(
//                        x: .value("Week", p.week),
//                        y: .value("Value", p.y)
//                    )
//                    .symbol(.circle)
//                    .symbolSize(40)
//                    .foregroundStyle(Color("primary"))
//                }
//            }
//            .chartXAxis {
//                AxisMarks(values: .automatic) { _ in
//                    AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))  // grid color
//                    AxisTick().foregroundStyle(Color("secondary").opacity(0.6))        // tick color
//                    AxisValueLabel()                                                   // label color + font
//                        .foregroundStyle(Color("text1"))
//                        .font(.system(size: 14, weight: .regular, design: .monospaced))
//                }
//            }
//            .chartYAxis {
//                AxisMarks(position: .leading) { _ in
//                    AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))
//                    AxisTick().foregroundStyle(Color("secondary").opacity(0.6))
//                    AxisValueLabel()
//                        .foregroundStyle(Color("text1"))
//                        .font(.system(size: 14, weight: .regular, design: .monospaced))
//                }
//            }
//            .chartYScale(domain: .automatic(includesZero: false))
//            .padding()
//            
//            HStack{
//                Image(systemName: "info.circle")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 14, height: 14)
//                    .foregroundStyle(Color("text2"))
//                
//                Text("This is what you could gain by following our program for 6 weeks")
//                    .font(.system(size: 14, weight: .light, design: .monospaced))
//                    .foregroundStyle(Color("text2"))
//            }
            
        }
    }
}

#Preview {
    @Previewable @State var previewVM = OnboardingViewModel(mockData: true)
    return ZStack {
        Color("background").ignoresSafeArea()
        ExtendedGoalScreen(viewModel: $previewVM)
    }
}
