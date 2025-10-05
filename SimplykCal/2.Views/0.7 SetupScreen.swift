//
//  0.7 SetupScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI
import SwiftData

struct SetupScreen: View {
    @Environment(\.modelContext) var modelContext
    @Binding var viewModel: OnboardingViewModel
    
    @Query private var users: [User]

    var body: some View {
        VStack {
            VStack{
                Image("mascot-happy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("All finished \(viewModel.name)")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Text("Im creating a program for you to help you reach your goal")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text2"))
                
                Spacer()
            }
            .padding()
            
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Let's get started!", fillColour: Color("primary"), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                let newUser = viewModel.generateNewUser()
                modelContext.insert(newUser)
                
                if let user = users.first{
                    print(user.age.description)
                    print(user.gender.rawValue)
                    print(user.goal.rawValue)
                    print(user.restrictions.count)
                }else{
                    print("User does not exist")
                }
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}
