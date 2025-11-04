//
//  0.3 DetailsScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct DetailsScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var showBirthdayPicker: Bool = false

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
                
                ScrollView{
                    //MARK: Birthday
                    VStack{
                        SKLabel(text: "Birthday")
                        
                        Button {
                            showBirthdayPicker = true
                        } label: {
                            SKDateContainer(dateString: DateFormattingUtil.formatDate(date: viewModel.birthday))
                        }
                        .tint(Color("primary"))
                        
                    }
                    .padding(.horizontal)
                    
                    //MARK: Height
                    VStack{
                        SKLabel(text: "Height")
                        
                        SKSlider(value: $viewModel.height, range: viewModel.heightRange, step: 0.5, unitOfMeasure: "cm")
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("background2"))
                            )
                            
                    }
                    .padding(.horizontal)

                    //MARK: Weight
                    VStack{
                        SKLabel(text: "Weight")
                        
                        SKSlider(value: $viewModel.weight, range: viewModel.weightRange, step: 0.5, unitOfMeasure: "kg")
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color("background2"))
                            )
                            
                    }
                    .padding(.horizontal)

                    // gender
                    VStack{
                        SKLabel(text: "Gender")
                        
                        HStack{
                            SKButton(title: "Male", isSelected: viewModel.gender == .male) {
                                viewModel.gender = .male
                            }
                            SKButton(title: "Female", isSelected: viewModel.gender == .female) {
                                viewModel.gender = .female
                            }
                            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.triggerSucessfulHaptic)
                            
                            
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .scrollIndicators(.hidden)
                
            }
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.height)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.weight)
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: !viewModel.isGenderValid(), action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
                viewModel.syncTargetWeight()
                viewModel.calculateBMR()
            })
            .padding()
        }
        .sheet(isPresented: $showBirthdayPicker, onDismiss: {
            showBirthdayPicker = false
        }) {
            SKDatePickerSheet(date: $viewModel.birthday, mode: .complex)
                .presentationDetents([.fraction(0.25)])
        }
    }
}

#Preview{
    ZStack{
        Color("background").ignoresSafeArea()
        
        DetailsScreen(viewModel: .constant(OnboardingViewModel()))

    }
}
