//
//  0.4 ActivityLevelScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct ActivityLevelScreen: View{
    @Binding var viewModel: OnboardingViewModel
    @State var errorMessage: String? = nil
    @State var selection: ActivityLevel? = nil
    
    var body: some View{
        VStack{
            VStack{
                switch selection {
                case .sedentary:
                    Image("mascot-activity-sedentary")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                case .light:
                    Image("mascot-activity-light")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                case .moderate:
                    Image("mascot-activity-moderate")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                case .veryActive:
                    Image("mascot-activity-heavy")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                case .extremelyActive:
                    Image("mascot-activity-extreme")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                case nil:
                    Image("mascot-noteTaking")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                }
                
                Text("How active are you?")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .padding(.bottom, 6)
                
                Text("We use this to do some super hard calculations to figure out the best possible plan for you.")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .multilineTextAlignment(.center)
            }
            .padding()
            .animation(.snappy, value: selection)
            
            VStack{
                SKButton(title: "Sedentary (little/no exercise)", isSelected: selection == .sedentary) {
                    selection = .sedentary
                }
                SKButton(title: "Lightly active (1–3x/week)", isSelected: selection == .light) {
                    selection = .light
                }
                SKButton(title: "Moderately active (3–5x/week)", isSelected: selection == .moderate) {
                    selection = .moderate
                }
                SKButton(title: "Very active (6–7x/week)", isSelected: selection == .veryActive) {
                    selection = .veryActive
                }
                SKButton(title: "Extremely active (athlete, labor job)", isSelected: selection == .extremelyActive) {
                    selection = .extremelyActive
                }
            }
            .padding()
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                errorMessage = viewModel.validateGender()
                
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

enum ActivityLevel{
    case sedentary
    case light
    case moderate
    case veryActive
    case extremelyActive
}

#Preview {
    ActivityLevelScreen(viewModel: .constant(OnboardingViewModel()))
}
