//
//  0.6 DieteryPreferancesScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct DieteryPreferancesScreen: View {
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            VStack{
                Image("mascot-noteTaking")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("\(viewModel.name) do you have any dietry restrictions?")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Text("This helps me personalize your meals and suggestions even better")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Spacer()
            }
            .padding()
            
            VStack{
                // the dietary choices choices
                VStack{
                    HStack{
                        Button {
                            viewModel.restrictions.append(.vegan)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.vegan.rawValue, isSelected: viewModel.restrictions.contains(.vegan))
                        }
                        
                        Button {
                            viewModel.restrictions.append(.vegetarian)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.vegetarian.rawValue, isSelected: viewModel.restrictions.contains(.vegetarian))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.restrictions.append(.pescatarian)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.pescatarian.rawValue, isSelected: viewModel.restrictions.contains(.pescatarian))
                        }
                        
                        Button {
                            viewModel.restrictions.append(.keto)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.keto.rawValue, isSelected: viewModel.restrictions.contains(.keto))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.restrictions.append(.glutenFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.glutenFree.rawValue, isSelected: viewModel.restrictions.contains(.glutenFree))
                        }
                        
                        Button {
                            viewModel.restrictions.append(.dairyFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.dairyFree.rawValue, isSelected: viewModel.restrictions.contains(.dairyFree))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.restrictions.append(.nutFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.nutFree.rawValue, isSelected: viewModel.restrictions.contains(.nutFree))
                        }
                        Button {
                            viewModel.restrictions.append(.peanutFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.peanutFree.rawValue, isSelected: viewModel.restrictions.contains(.peanutFree))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.restrictions.append(.eggFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.eggFree.rawValue, isSelected: viewModel.restrictions.contains(.eggFree))
                        }
                        Button {
                            viewModel.restrictions.append(.soyFree)
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.soyFree.rawValue, isSelected: viewModel.restrictions.contains(.soyFree))
                        }
                    }
                    
                }
                .padding(.horizontal)
                .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.restrictions)
                
                Spacer()
            }
        }
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
