//
//  OnboardingView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/05/2025.
//

import SwiftUI
import Charts
import SwiftData

struct OnboardingView: View {
    @State var viewModel: OnboardingViewModel = OnboardingViewModel()
    @Binding var isOnboardingComplete: Bool

    var body: some View {
        ZStack{
            if viewModel.screenStep == 0 {
                IntroScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 1 {
                NameScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 2 {
                DetailsScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 3 {
                GoalScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 4 {
                DieteryPreferancesScreen(viewModel: $viewModel)
            } else if viewModel.screenStep == 5 {
                SetupScreen(viewModel: $viewModel, isOnboardingComplete: $isOnboardingComplete)
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

//MARK: INTRO SCREEN
private struct IntroScreen: View {
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

//MARK: NAME SCREEN
private struct NameScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var errorMessage: String? = nil

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
            
            SKTextField(text: $viewModel.name, errorMessage: errorMessage)
                .padding(.horizontal)
            
            Spacer()
            
            
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                errorMessage = viewModel.validateUserName()
                
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

//MARK: DETAILS SCREEN
private struct DetailsScreen: View {
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
                            GenderButton(title: "Male", isSelected: viewModel.gender == .male) {
                                viewModel.gender = .male
                            }
                            GenderButton(title: "Female", isSelected: viewModel.gender == .female) {
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

//MARK: GoalScreen
private struct GoalScreen: View {
    @Binding var viewModel: OnboardingViewModel
    @State var errorMessage: String? = nil
    
    var body: some View {
        VStack(spacing: 0) {
            // simply & text
            VStack{
                Image("mascot-noteTaking")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("What's your goal")
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .padding(.bottom, 6)
                    .foregroundStyle(Color("text1"))
                
                Text("🤝 This helps me personalize your experience")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 12)
                    .foregroundStyle(Color("text2"))
                    .frame(height: 50)
            }
            .padding()
            

            HStack{
                SKActionButton(title: "Lose weight", fillColour: Color.green, textSize: 14, isSelected: viewModel.goal == .lose) {
                    viewModel.goal = .lose
                    viewModel.generateGraphPointsForLoss()
                    errorMessage = viewModel.validateGoal()
                }
                
                SKActionButton(title: "Maintain weight", fillColour: Color.orange, textSize: 14, isSelected: viewModel.goal == .maintain) {
                    viewModel.goal = .maintain
                    errorMessage = viewModel.validateGoal()
                }
                
                SKActionButton(title: "Gain weight", fillColour: Color.red, textSize: 14, isSelected: viewModel.goal == .gain) {
                    viewModel.goal = .gain
                    viewModel.generateGraphPointsForGain()
                    errorMessage = viewModel.validateGoal()
                }
            }
            .padding(.horizontal)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: viewModel.goal)
            
            if let errorMessage{
                Text(errorMessage)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            
            // if the goal is to lose weight
            if viewModel.goal == .lose {
                VStack{
                    HStack{
                        Text("Slower")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Slider(value: $viewModel.paceForWeightLoss, in: 10...100, step: 10)
                            .tint(Color("primary"))
                            .padding(.horizontal)
                            .padding(.top, 6)
                        
                        Text("Faster")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Text(String(format: "%.2f%%", viewModel.paceForWeightLoss / 100.0))
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 6)
                        
                        Text("of your body weight per week")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: viewModel.paceForWeightLoss)
                    // LINE GRAPH
                    Chart {
                        ForEach(viewModel.graphData) { p in
                            LineMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .interpolationMethod(.linear)
                            .lineStyle(.init(lineWidth: 2, lineCap: .round))
                            .foregroundStyle(Color("primary"))

                            PointMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .symbol(.circle)
                            .symbolSize(40)
                            .foregroundStyle(Color("primary"))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))  // grid color
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))        // tick color
                            AxisValueLabel()                                                   // label color + font
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))
                            AxisValueLabel()
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYScale(domain: .automatic(includesZero: false))
                    .padding()
                    
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color("text2"))
                        
                        Text("This is what you could lose by following our program for 6 weeks")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                }
            }
            // if the goal is to gain weight
            else if viewModel.goal == .gain{
                VStack{
                    HStack{
                        Text("Slower")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Slider(value: $viewModel.paceForWeightGain, in: 10...100, step: 10)
                            .tint(Color("primary"))
                            .padding(.top, 6)
                            .padding(.horizontal)
                        
                        Text("Faster")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                    }
                    .padding(.horizontal)
                    
                    VStack{
                        Text(String(format: "%.2f%%", viewModel.paceForWeightGain / 100.0))
                            .font(.system(size: 16, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.top, 6)
                        
                        
                        Text("of your body weight per week")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: viewModel.paceForWeightGain)
                    
                    
                    
                    Chart {
                        ForEach(viewModel.graphData) { p in
                            LineMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .interpolationMethod(.linear)
                            .lineStyle(.init(lineWidth: 2, lineCap: .round))
                            .foregroundStyle(Color("primary"))
                            
                            PointMark(
                                x: .value("Week", p.week),
                                y: .value("Value", p.y)
                            )
                            .symbol(.circle)
                            .symbolSize(40)
                            .foregroundStyle(Color("primary"))
                        }
                    }
                    .chartXAxis {
                        AxisMarks(values: .automatic) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))  // grid color
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))        // tick color
                            AxisValueLabel()                                                   // label color + font
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYAxis {
                        AxisMarks(position: .leading) { _ in
                            AxisGridLine().foregroundStyle(Color("secondary").opacity(0.15))
                            AxisTick().foregroundStyle(Color("secondary").opacity(0.6))
                            AxisValueLabel()
                                .foregroundStyle(Color("text1"))
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                        }
                    }
                    .chartYScale(domain: .automatic(includesZero: false))
                    .padding()
                    
                    HStack{
                        Image(systemName: "info.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 14, height: 14)
                            .foregroundStyle(Color("text2"))
                        
                        Text("This is what you could gain by following our program for 6 weeks")
                            .font(.system(size: 14, weight: .light, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    
                }
            }
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                errorMessage = viewModel.validateGoal()
                
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

private struct DieteryPreferancesScreen: View {
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

private struct SetupScreen: View {
    @Environment(\.modelContext) var modelContext
    @Binding var viewModel: OnboardingViewModel
    @Binding var isOnboardingComplete: Bool
    
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
                isOnboardingComplete = true
                
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

private struct BackButtonLabel: View {
    var isHidden: Bool? = false
    var body: some View {
        Image(systemName: "chevron.left")
            .font(.body.bold())
            .foregroundColor(isHidden ?? false ? Color.clear : Color("text2"))
    }

}

private struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(isSelected ? Color("text3") : Color("text1"))
            }
            .padding(.horizontal, 14)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color("primary") : Color("background2"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color("primary"), lineWidth: 1)
            )
        }
    }
}

private struct RestrictionButtonLabel: View {
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
    OnboardingView(isOnboardingComplete: .constant(false))
    
//    GoalScreen(screenStep: .constant(1))
//        .background(Color("background"))
}
