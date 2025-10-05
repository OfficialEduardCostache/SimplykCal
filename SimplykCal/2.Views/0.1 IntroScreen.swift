//
//  0.1 IntroScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct IntroScreen: View {
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Image("mascot-waving")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .shadow(color: Color("primary").opacity(0.3), radius: 5)
            
            Text("Hi, I'm Simply")
                .font(.system(size: 16, weight: .bold, design: .monospaced))
                .padding(.bottom)
                .foregroundStyle(Color("text1"))
            
            Text("Your AI nutritionist and fitness companion")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .multilineTextAlignment(.center)
                .padding(.bottom, 6)
                .foregroundStyle(Color("text2"))
            
            Text("🚀 Let's get started!")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundStyle(Color("text2"))
            
            Spacer()
        }
        .padding()
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

#Preview{
    IntroScreen(viewModel: .constant(OnboardingViewModel()))
}
