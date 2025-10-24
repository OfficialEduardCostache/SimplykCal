//
//  0.2 NameScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct NameScreen: View {
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            VStack{
                Image("mascot-curious")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("What's your name?")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Text("☺️ Let's get to know each other")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color("text2"))
            }
            .padding()
            
            SKTextField(text: $viewModel.name)
                .padding(.horizontal)
            
            Spacer()
            
            
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: !viewModel.isUsernameValid(), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            })
            .padding()
        }
    }
}

#Preview{
    NameScreen(viewModel: .constant(OnboardingViewModel()))
}
