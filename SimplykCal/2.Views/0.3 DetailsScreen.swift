//
//  0.3 DetailsScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct DetailsScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var errorMessage: String? = nil

    var body: some View {
        VStack{
            VStack{
                VStack{
                    Image("mascot-noteTaking")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                    
                    Text("Nice to meet you \(viewModel.name)")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .padding(.bottom, 6)
                    
                    Text("🧐 Tell me about yourself")
                        .font(.system(size: 14, weight: .regular, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                }
                .padding()
                
                //MARK: Age
                VStack(spacing: 20){
                    VStack{
                        VStack(spacing: -20) {
                            Text("Age")
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                //.background(Color.blue)
                            
                            Text(String(format: "%.0f", viewModel.age))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.background(Color.red)
                        }
                        
                        HStack {
                            Button {
                                viewModel.decrementAge()
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }

                            Slider(value: $viewModel.age, in: viewModel.ageRange, step: 1.0)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                viewModel.incrementAge()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                    
                    //MARK: Height
                    VStack{
                        VStack(spacing: -20) {
                            Text("Height")
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Text(String(format: "%.0fcm", viewModel.height))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        HStack {
                            Button {
                                viewModel.decrementHeight()
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }

                            Slider(value: $viewModel.height, in: viewModel.heightRange, step: 1)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                viewModel.incrementHeight()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)

                    //MARK: Weight
                    VStack{
                        VStack(spacing: -20) {
                            Text("Weight")
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                //.background(Color.blue)
                            
                            Text(String(format: "%.0fkg", viewModel.weight))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.background(Color.red)
                        }
                        
                        HStack {
                            Button {
                                viewModel.decrementWeight()
                            } label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }

                            Slider(value: $viewModel.weight, in: viewModel.weightRange, step: 1.0)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                viewModel.incrementWeight()
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.black)
                                    .frame(width: 22, height: 22)
                                    .background(
                                        Circle()
                                            .fill(Color("primary"))
                                            .frame(width: 32, height: 32)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)


                    // gender
                    VStack{
                        Text("Gender")
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        HStack{
                            SKButton(title: "Male", isSelected: viewModel.gender == .male) {
                                viewModel.gender = .male
                            }
                            SKButton(title: "Female", isSelected: viewModel.gender == .female) {
                                viewModel.gender = .female
                            }
                            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.triggerSucessfulHaptic)
                            
                            
                        }
                        
                        if let errorMessage{
                            Text(errorMessage)
                                .font(.system(size: 12, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                
            }
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.age)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.height)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.weight)
            
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
