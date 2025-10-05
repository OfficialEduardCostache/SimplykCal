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
                            viewModel.handleRestrictionSelection(restriction: .vegan)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.vegan.rawValue, isSelected: viewModel.restrictions.contains(.vegan))
                        }
                        
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .vegetarian)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.vegetarian.rawValue, isSelected: viewModel.restrictions.contains(.vegetarian))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .pescatarian)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.pescatarian.rawValue, isSelected: viewModel.restrictions.contains(.pescatarian))
                        }
                        
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .keto)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.keto.rawValue, isSelected: viewModel.restrictions.contains(.keto))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .glutenFree)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.glutenFree.rawValue, isSelected: viewModel.restrictions.contains(.glutenFree))
                        }
                        
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .dairyFree)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.dairyFree.rawValue, isSelected: viewModel.restrictions.contains(.dairyFree))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .nutFree)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.nutFree.rawValue, isSelected: viewModel.restrictions.contains(.nutFree))
                        }
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .peanutFree)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.peanutFree.rawValue, isSelected: viewModel.restrictions.contains(.peanutFree))
                        }
                    }
                    HStack{
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .eggFree)
                            viewModel.triggerSucessfulHaptic.toggle()
                        } label: {
                            RestrictionButtonLabel(restrictionName: Restriction.eggFree.rawValue, isSelected: viewModel.restrictions.contains(.eggFree))
                        }
                        Button {
                            viewModel.handleRestrictionSelection(restriction: .soyFree)
                            viewModel.triggerSucessfulHaptic.toggle()
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

#Preview{
    DieteryPreferancesScreen(viewModel: .constant(OnboardingViewModel()))
}
