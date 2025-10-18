//
//  0.6 DieteryPreferancesScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct MacroBalancingScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var proteinSliderSelection: Double = 1
    @State var error: Bool = false
    
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    Text("Choose your fat/carbs ratio")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    SKButton(title: CarbFatBalance.balanced.rawValue,isSelected: viewModel.carbFatBalance == .balanced,alignment: .leading) {
                        viewModel.carbFatBalance = .balanced
                        viewModel.calculateMacroDistribution()
                    }
                    .padding(.horizontal)
                    
                    SKButton(title: CarbFatBalance.lowFat.rawValue,isSelected: viewModel.carbFatBalance == .lowFat,alignment: .leading) {
                        viewModel.carbFatBalance = .lowFat
                        viewModel.calculateMacroDistribution()
                    }
                    .padding(.horizontal)
                    
                    SKButton(title: CarbFatBalance.lowCarb.rawValue,isSelected: viewModel.carbFatBalance == .lowCarb,alignment: .leading) {
                        viewModel.carbFatBalance = .lowCarb
                        viewModel.calculateMacroDistribution()
                    }
                    .padding(.horizontal)
                    
                    SKButton(title: CarbFatBalance.keto.rawValue,isSelected: viewModel.carbFatBalance == .keto,alignment: .leading) {
                        viewModel.carbFatBalance = .keto
                        viewModel.calculateMacroDistribution()
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("background2"))
                )
                .padding(.horizontal)
                .padding(.vertical, 4)
                
                VStack{
                    Text("Choose your protein intake")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    VStack {
                        Text(viewModel.proteinIntake.rawValue)
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .padding(6)
                            .background(
                                RoundedRectangle(cornerRadius: 6)
                                    .fill({
                                        switch viewModel.proteinIntake {
                                        case .low:
                                            Color.orange.opacity(0.5)
                                        case .moderate:
                                            Color.yellow.opacity(0.5)
                                        case .high:
                                            Color.green.opacity(0.5)
                                        case .extraHigh:
                                            Color.blue.opacity(0.5)
                                        }
                                    }())
                            )
                        
                        
                        Slider(value: $proteinSliderSelection, in: 0...3, step: 1)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .tint(Color("primary"))
                            .onChange(of: proteinSliderSelection) { _, newValue in
                                viewModel.updateProteinIntake(selectionAsSliderValue: newValue)
                                viewModel.calculateMacroDistribution()
                            }
                    }
                    .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("background2"))
                )
                .padding(.horizontal)
                .padding(.vertical, 4)
                
                VStack{
                    Text("Macro Breakdown")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                    HStack{
                        VStack{
                            Image("protein")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text("Protein")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Text("99%")
                                .font(.system(size: 14, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        .padding(.leading)
                        Spacer()
                        VStack{
                            Image("fats")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text("Fats")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Text("99%")
                                .font(.system(size: 14, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        Spacer()
                        VStack{
                            Image("carbs")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                            
                            Text("Carbs")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Text("99%")
                                .font(.system(size: 14, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        .padding(.trailing)
                    }
                    .padding(.bottom)
                }
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color("background2"))
                )
                .padding(.horizontal)
                .padding(.vertical, 4)
            }
            .scrollIndicators(.hidden)
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next",fillColour: Color("primary"),isDisabled: viewModel.carbFatBalance == nil) {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            }
            .padding()
            .padding(.bottom, 40)
        }
    }
}

#Preview{
    @Previewable @State var previewVM: OnboardingViewModel = OnboardingViewModel(mockData: true)
    ZStack{
        Color("background").ignoresSafeArea()
        
        MacroBalancingScreen(viewModel: $previewVM)
    }
}
