//
//  0.5 GoalScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI
import Charts

struct GoalScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var errorMessage: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            // simply & text
            VStack{
                Image("mascot-noteTaking")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("What's your goal")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Text("🤝 This helps me personalize your experience")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                    .foregroundStyle(Color("text2"))
                    .frame(height: 50)
            }
            .padding()
            

            HStack{
                SKButton(title: "Lose weight", isSelected: viewModel.goal == .lose) {
                    viewModel.goal = .lose
                    viewModel.generateGraphPointsForLoss()
                    errorMessage = viewModel.validateGoal()
                }
                
                SKButton(title: "Maintain weight", isSelected: viewModel.goal == .maintain) {
                    viewModel.goal = .maintain
                    errorMessage = viewModel.validateGoal()
                }
                
                SKButton(title: "Gain weight", isSelected: viewModel.goal == .gain) {
                    viewModel.goal = .gain
                    viewModel.generateGraphPointsForGain()
                    errorMessage = viewModel.validateGoal()
                }
            }
            .padding(.horizontal)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.goal)
            
            if let errorMessage{
                Text(errorMessage)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            // if the goal is to lose weight
            if viewModel.goal == .lose {
                VStack{
                    HStack{
                        Text("Slower")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Slider(value: $viewModel.paceForWeightLoss, in: 10...100, step: 10)
                            .tint(Color("primary"))
                            .padding(.horizontal)
                            .padding(.top, 6)
                        
                        Text("Faster")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Text(String(format: "%.2f%%", viewModel.paceForWeightLoss / 100.0))
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 6)
                        
                        Text("of your body weight per week")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: viewModel.paceForWeightLoss)
                    // LINE GRAPH
                    Chart {
                        ForEach(viewModel.graphData) { p in
                            LineMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .interpolationMethod(.linear)
                            .lineStyle(.init(lineWidth: 2, lineCap: .round))
                            .foregroundStyle(Color("primary"))

                            PointMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .symbol(.circle)
                            .symbolSize(40)
                            .foregroundStyle(Color("primary"))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))  // grid color
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))        // tick color
                            AxisValueLabel()                                                   // label color + font
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))
                            AxisValueLabel()
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYScale(domain: .automatic(includesZero: false))
                    .padding()
                    
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color("text2"))
                        
                        Text("This is what you could lose by following our program for 6 weeks")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                }
            }
            // if the goal is to gain weight
            else if viewModel.goal == .gain{
                VStack{
                    HStack{
                        Text("Slower")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Slider(value: $viewModel.paceForWeightGain, in: 10...100, step: 10)
                            .tint(Color("primary"))
                            .padding(.top, 6)
                            .padding(.horizontal)
                        
                        Text("Faster")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Text(String(format: "%.2f%%", viewModel.paceForWeightGain / 100.0))
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 6)
                        
                        
                        Text("of your body weight per week")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: viewModel.paceForWeightGain)
                    
                    
                    
                    Chart {
                        ForEach(viewModel.graphData) { p in
                            LineMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .interpolationMethod(.linear)
                            .lineStyle(.init(lineWidth: 2, lineCap: .round))
                            .foregroundStyle(Color("primary"))
                            
                            PointMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .symbol(.circle)
                            .symbolSize(40)
                            .foregroundStyle(Color("primary"))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))  // grid color
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))        // tick color
                            AxisValueLabel()                                                   // label color + font
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))
                            AxisValueLabel()
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYScale(domain: .automatic(includesZero: false))
                    .padding()
                    
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color("text2"))
                        
                        Text("This is what you could gain by following our program for 6 weeks")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    
                }
            }
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                errorMessage = viewModel.validateGoal()
                
                if errorMessage == nil{
                    viewModel.triggerSucessfulHaptic.toggle()
                    viewModel.next()
                }
                else{
                    viewModel.triggerErrorHaptic.toggle()
                }
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

#Preview{
    GoalScreen(viewModel: .constant(OnboardingViewModel()))
}
