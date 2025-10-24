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
            VStack{
                HStack{
                    //MARK: Calories container
                    VStack(alignment: .leading){
                        Text(String(format: "%.0f", viewModel.macros.calories))
                            .font(.system(size: 16, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("Daily Calories")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("background2"))
                    )
                    
                    //MARK: Date container
                    VStack(alignment: .leading){
                        Text(viewModel.formatDate(date: viewModel.expectedEndDate))
                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Text("Expected End Date")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
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
                
                //MARK: Target weight slider
                Text("What is your target weight?")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                SKSlider(value: $viewModel.targetWeight, range: goal == .lose ? (viewModel.weight * 0.5)...viewModel.weight : viewModel.weight...(viewModel.weight * 1.5), step: 0.5, unitOfMeasure: "kg")
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                    .padding(.horizontal)
                    .padding(.bottom)

                
                //MARK: Rate of goal slider
                Text("How fast do you want to get there?")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom)
                    .padding(.horizontal)
                
                Slider(value: $viewModel.weeklyPercentage, in: 0.25...1.0, step: 0.01)
                    .tint(Color("primary"))
                    .padding(.bottom)
                    .padding(.horizontal)
                
                //MARK: Information container
                VStack{
                    HStack{
                        Text(goal == .lose ? "-" : "+")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        HStack(spacing: 2) {
                            Text(String(format: "%.3f", viewModel.weeklyWeight))
                                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))

                            
                            Text("kg")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                        }
                        .frame(width: 85)
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
                            Text(String(format: "%.2f", viewModel.weeklyPercentage))
                                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                
                            
                            Text("% BW")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                        }
                        .frame(width: 85)
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
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                    
                    HStack{
                        Text(goal == .lose ? "-" : "+")
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                        
                        HStack(spacing: 2) {
                            Text(String(format: "%.3f", viewModel.monthlyWeight))
                                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))

                            
                            Text("kg")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                        }
                        .frame(width: 85)
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
                            Text(String(format: "%.2f", viewModel.monthlyPercentage))
                                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))

                            
                            Text("% BW")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                        }
                        .frame(width: 85)
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
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .onAppear(perform: {
                viewModel.updateWeeklyMontlyVariables()
                viewModel.calculateNewCalories()
            })
            //MARK: Next Button
            .safeAreaInset(edge: .bottom) {
                SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: false, action: {
                    viewModel.triggerSucessfulHaptic.toggle()
                    viewModel.next()
                })
                .padding()
            }
        }
        else{
            EmptyView()
        }
    }
}

#Preview {
    @Previewable @State var previewVM = OnboardingViewModel(mockData: true)
    ZStack {
        Color("background").ignoresSafeArea()
        ExtendedGoalScreen(viewModel: $previewVM)
    }
}
