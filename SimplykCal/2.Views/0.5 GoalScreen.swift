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
            

            VStack{
                SKButton(title: "Lose weight", isSelected: viewModel.goal == .lose, icon: Image(systemName: "chart.line.downtrend.xyaxis"), alignment: .leading) {
                    viewModel.goal = .lose
                    viewModel.generateGraphPointsForLoss()
                    errorMessage = viewModel.validateGoal()
                }
                
                SKButton(title: "Maintain weight", isSelected: viewModel.goal == .maintain, icon: Image(systemName: "chart.line.flattrend.xyaxis"), alignment: .leading) {
                    viewModel.goal = .maintain
                    errorMessage = viewModel.validateGoal()
                }
                
                SKButton(title: "Gain weight", isSelected: viewModel.goal == .gain, icon: Image(systemName: "chart.line.uptrend.xyaxis"), alignment: .leading) {
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
