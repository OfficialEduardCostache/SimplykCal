//
//  OnboardingView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/05/2025.
//

import SwiftUI

struct OnboardingView: View {
    @State var viewModel: OnboardingViewModel = OnboardingViewModel()

    var body: some View {
        VStack{
            ZStack{
                // Back button
                Button {
                    viewModel.triggerSucessfulHaptic.toggle()
                    viewModel.back()
                    
                } label: {
                    BackButtonLabel(isHidden: viewModel.screenStep == 0 ? true : false)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .disabled(viewModel.screenStep == 0 ? true : false)
                
                HStack{
                    ForEach(0..<viewModel.totalSteps, id: \.self) { step in
                        RoundedRectangle(cornerRadius: 4)
                            .fill(step == viewModel.screenStep ? Color("primary") : Color("primary").opacity(0.1))
                            .frame(width: 24, height: 6)
                    }
                }
            }
            .padding(.bottom, 2)
            
            switch viewModel.screenStep {
            case 0:
                IntroScreen(viewModel: $viewModel)
            case 1:
                NameScreen(viewModel: $viewModel)
            case 2:
                DetailsScreen(viewModel: $viewModel)
            case 3:
                ActivityLevelScreen(viewModel: $viewModel)
            case 4:
                GoalScreen(viewModel: $viewModel)
            case 5:
                ExtendedGoalScreen(viewModel: $viewModel)
            case 6:
                MacroBalancingScreen(viewModel: $viewModel)
            case 7:
                GoalSummaryScreen(viewModel: $viewModel)
            case 8:
                SetupScreen(viewModel: $viewModel)
            default:
                EmptyView()
            }
        }
        .background(Color("background").ignoresSafeArea())
        .overlay{
            Color("background")
                .opacity(viewModel.fadeOpacity)
        }
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.5), trigger: viewModel.triggerSucessfulHaptic)
        .sensoryFeedback(.impact(flexibility: .rigid, intensity: 0.7), trigger: viewModel.triggerErrorHaptic)
    }
}

private struct BackButtonLabel: View {
    var isHidden: Bool? = false
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.body.bold())
            .foregroundColor(isHidden ?? false ? Color.clear : Color("text2"))
    }

}

#Preview{
    OnboardingView()
    
//    GoalScreen(screenStep: .constant(1))
//        .background(Color("background"))
}
