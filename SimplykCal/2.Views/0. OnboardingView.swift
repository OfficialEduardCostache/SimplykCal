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
        ZStack{
            if viewModel.screenStep == 0 {
                IntroScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 1 {
                NameScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 2 {
                DetailsScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 3 {
                ActivityLevelScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 4 {
                GoalScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 5 {
                DieteryPreferancesScreen(viewModel: $viewModel)
            }else if viewModel.screenStep == 6{
                SetupScreen(viewModel: $viewModel)
            }

            Rectangle()
                .fill(Color("background"))
                .opacity(viewModel.fadeOpacity)
                .ignoresSafeArea(.all)
        }
        .background(Color("background").ignoresSafeArea())
        .safeAreaInset(edge: .top) {
            HStack{
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
                
                ForEach(0..<viewModel.totalSteps, id: \.self) { step in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(step == viewModel.screenStep ? Color("primary") : Color("primary").opacity(0.1))
                        .frame(width: 24, height: 6)
                }
                
                // Skip button / not in use at the moment
                Button {
                    viewModel.triggerSucessfulHaptic.toggle()
                    viewModel.next()
                } label: {
                    Text("Skip")
                        .font(.system(size: 16, weight: .regular, design: .monospaced))
                        .foregroundStyle(Color.clear)
                        
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing, 20)
                .disabled(true)
            }
            .overlay{
                Color("background")
                    .opacity(viewModel.fadeOpacity)
            }
            .padding(.top, 20)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.5), trigger: viewModel.triggerSucessfulHaptic)
            .sensoryFeedback(.impact(flexibility: .rigid, intensity: 0.7), trigger: viewModel.triggerErrorHaptic)
        }
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

struct RestrictionButtonLabel: View {
    let restrictionName: String
    var isSelected: Bool
    var body: some View {
        Text(restrictionName)
            .font(.system(size: 14, weight: .semibold, design: .monospaced))
            .foregroundStyle(isSelected ? Color("text3") : Color("text2"))
            .padding(8)
            .background(
                RoundedRectangle(cornerRadius: 4)
                    .fill(isSelected ? Color("primary") : Color("background2"))
            )
            .overlay {
                RoundedRectangle(cornerRadius: 4)
                    .stroke(isSelected ? Color("primary") : Color.clear)
            }
    }
}


#Preview{
    OnboardingView()
    
//    GoalScreen(screenStep: .constant(1))
//        .background(Color("background"))
}
