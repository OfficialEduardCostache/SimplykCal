//
//  OnboardingView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/05/2025.
//

import SwiftUI
import Charts

struct OnboardingView: View {
    @State var screenStep: Int = 0
    
    @State var nameText: String = ""
    @State private var fadeOpacity: Double = 0
    
    @Binding var isOnboardingComplete: Bool
    
    @State var triggerHaptics: Bool = false

    private let totalSteps: Int = 6
    private let fadeDuration: Double = 0.4

    // Intercepts child screen writes to `screenStep` to perform fade-out → change → fade-in
    private var animatedScreenStep: Binding<Int> {
        Binding(
            get: { screenStep },
            set: { newValue in
                guard newValue != screenStep else { return }
                withAnimation(.easeInOut(duration: fadeDuration)) { fadeOpacity = 1 }
                DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) {
                    screenStep = newValue
                    withAnimation(.easeInOut(duration: fadeDuration)) { fadeOpacity = 0 }
                }
            }
        )
    }

    var body: some View {
        ZStack{
            if screenStep == 0 {
                IntroScreen(screenStep: animatedScreenStep, triggerHaptics: $triggerHaptics)
            } else if screenStep == 1 {
                NameScreen(screenStep: animatedScreenStep, nameText: $nameText, triggerHaptics: $triggerHaptics)
            } else if screenStep == 2 {
                DetailsScreen(screenStep: animatedScreenStep, triggerHaptics: $triggerHaptics)
            } else if screenStep == 3 {
                GoalScreen(screenStep: animatedScreenStep, triggerHaptics: $triggerHaptics)
            } else if screenStep == 4 {
                DieteryPreferancesScreen(screenStep: animatedScreenStep, triggerHaptics: $triggerHaptics)
            } else if screenStep == 5 {
                SetupScreen(screenStep: animatedScreenStep, isOnboardingComplete: $isOnboardingComplete, triggerHaptics: $triggerHaptics)
            }

            Rectangle()
                .fill(Color("background"))
                .opacity(fadeOpacity)
                .ignoresSafeArea(.all)
        }
        .background(Color("background").ignoresSafeArea())
        .safeAreaInset(edge: .top) {
            HStack{
                // Back button
                Button {
                    triggerHaptics.toggle()
                    screenStep -= 1
                } label: {
                    BackButtonLabel(isHidden: screenStep == 0 ? true : false)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 20)
                .disabled(screenStep == 0 ? true : false)
                
                ForEach(0..<totalSteps, id: \.self) { step in
                    RoundedRectangle(cornerRadius: 4)
                        .fill(step == screenStep ? Color("primary") : Color("primary").opacity(0.1))
                        .frame(width: 24, height: 6)
                }
                
                // Skip button / not in use at the moment
                Button {
                    triggerHaptics.toggle()
                    screenStep += 1
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
                    .opacity(fadeOpacity)
            }
            .padding(.top, 20)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.5), trigger: triggerHaptics)
        }
    }
}

private struct IntroScreen: View {
    @Binding var screenStep: Int
    @Binding var triggerHaptics: Bool
    
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
                triggerHaptics.toggle()
                screenStep += 1
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

private struct NameScreen: View {
    @Binding var screenStep: Int
    @Binding var nameText: String
    @Binding var triggerHaptics: Bool

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
            
            SKTextField(text: $nameText)
                .padding(.horizontal)
            
            Spacer()
            
            
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                triggerHaptics.toggle()
                screenStep += 1
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

//MARK: DETAILS SCREEN
private struct DetailsScreen: View {
    @State private var selectedGender: String? = nil
    @Binding var screenStep: Int
    @Binding var triggerHaptics: Bool
    
    @State var age: Double = 25
    let ageRange: ClosedRange<Double> = 16...80
    
    @State var height: Double = 177
    let heightRange: ClosedRange<Double> = 120...250
    
    @State var weight: Double = 70
    let weightRange: ClosedRange<Double> = 35...105
    
    
    var body: some View {
        VStack{
            VStack{
                VStack{
                    Image("mascot-noteTaking")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140, height: 140)
                        .shadow(color: Color("primary").opacity(0.3), radius: 5)
                    
                    Text("Nice to meet you ____")
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
                            
                            Text(String(format: "%.0f", age))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.background(Color.red)
                        }
                        
                        HStack {
                            Button {
                                if age > ageRange.lowerBound{
                                    age -= 1
                                }
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

                            Slider(value: $age, in: ageRange, step: 1.0)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                if age < ageRange.upperBound{
                                    age += 1
                                }
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
                            
                            Text(String(format: "%.0fcm", height))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        
                        HStack {
                            Button {
                                if height > heightRange.lowerBound{
                                    height -= 1
                                }
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

                            Slider(value: $height, in: heightRange, step: 1)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                if height < heightRange.upperBound{
                                    height += 1
                                }
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
                            
                            Text(String(format: "%.0fkg", weight))
                                .font(.system(size: 18, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                //.background(Color.red)
                        }
                        
                        HStack {
                            Button {
                                if weight > weightRange.lowerBound{
                                    weight -= 1
                                }
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

                            Slider(value: $weight, in: weightRange, step: 1.0)
                                .tint(Color("primary"))
                                .padding(.horizontal, 6)
                            
                            
                            Button {
                                if weight < weightRange.upperBound{
                                    weight += 1
                                }
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
                            GenderButton(title: "Male", isSelected: selectedGender == "Male") {
                                selectedGender = "Male"
                            }
                            GenderButton(title: "Female", isSelected: selectedGender == "Female") {
                                selectedGender = "Female"
                            }
                            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: selectedGender)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                }
                
            }
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: age)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: height)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: weight)
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                triggerHaptics.toggle()
                screenStep += 1
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

//MARK: GoalScreen
private struct GoalScreen: View {
    @Binding var screenStep: Int
    @Binding var triggerHaptics: Bool
    
    // 0 - Lose weight
    // 1 - Maintain weight
    // 2 - Gain weight
    @State var selectedGoal: Int? = nil
    
    @State var paceForWeightLoss: Double = 50
    @State var paceForWeightGain: Double = 50
    
    private let data: [TrendPoint] = [
        TrendPoint(week: "W1", y: 70),
        TrendPoint(week: "W2", y: 67),
        TrendPoint(week: "W3", y: 65),
        TrendPoint(week: "W4", y: 63),
        TrendPoint(week: "W5", y: 61),
        TrendPoint(week: "W6", y: 60)
    ]
    
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
                SKActionButton(title: "Lose weight", fillColour: Color.green, textSize: 14, isSelected: selectedGoal == 0) {
                    selectedGoal = 0
                }
                
                SKActionButton(title: "Maintain weight", fillColour: Color.orange, textSize: 14, isSelected: selectedGoal == 1) {
                    selectedGoal = 1
                }
                
                SKActionButton(title: "Gain weight", fillColour: Color.red, textSize: 14, isSelected: selectedGoal == 2) {
                    selectedGoal = 2
                }
            }
            .padding(.horizontal)
            .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: selectedGoal)
            
            if let selectedGoal = selectedGoal{
                // if the goal is to lose weight
                if selectedGoal == 0 {
                    VStack{
                        HStack{
                            Text("Slower")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Slider(value: $paceForWeightLoss, in: 10...100, step: 10)
                                .tint(Color("primary"))
                                .padding(.horizontal)
                                .padding(.top, 6)
                            
                            Text("Faster")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        .padding(.horizontal)
                        
                        VStack{
                            Text(String(format: "%.2f%%", paceForWeightLoss / 100.0))
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top, 6)
                            
                            Text("of your body weight per week")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: paceForWeightLoss)
                        // LINE GRAPH
                        Chart {
                            ForEach(data) { p in
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
                else if selectedGoal == 2{
                    VStack{
                        HStack{
                            Text("Slower")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Slider(value: $paceForWeightGain, in: 10...100, step: 10)
                                .tint(Color("primary"))
                                .padding(.top, 6)
                                .padding(.horizontal)
                            
                            Text("Faster")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        .padding(.horizontal)
                        
                        VStack{
                            Text(String(format: "%.2f%%", paceForWeightGain / 100.0))
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(.top, 6)

                            
                            Text("of your body weight per week")
                                .font(.system(size: 14, weight: .regular, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                                .frame(maxWidth: .infinity, alignment: .center)
                        }
                        .sensoryFeedback(.impact(flexibility: .solid, intensity: 1), trigger: paceForWeightGain)
                        

                        
                        Chart {
                            ForEach(data) { p in
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
            }
            
            Spacer()
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                triggerHaptics.toggle()
                screenStep += 1
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

enum Restriction: String, CaseIterable, Hashable {
    case vegetarian = "Vegetarian"
    case vegan = "Vegan"
    case pescatarian = "Pescatarian"
    case keto = "Keto / Low-Carb"
    case glutenFree = "Gluten-Free"
    case dairyFree = "Dairy-Free"
    case nutFree = "Nut-Free"
    case peanutFree = "Peanut-Free"
    case eggFree = "Egg-Free"
    case soyFree = "Soy-Free"
}

private struct DieteryPreferancesScreen: View {
    @Binding var screenStep: Int
    @Binding var triggerHaptics: Bool
    
    @State private var restrictions: [Restriction: Bool] = [
        .vegan: false,
        .vegetarian: false,
        .pescatarian: false,
        .keto: false,
        .glutenFree: false,
        .dairyFree: false,
        .nutFree: false,
        .peanutFree: false,
        .eggFree: false,
        .soyFree: false
    ]
    
    var selected: [Restriction] { restrictions.filter { $0.value }.map(\.key) }
    
    var body: some View {
        VStack {
            VStack{
                Image("mascot-noteTaking")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("___ do you have any dietry restrictions?")
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
                        RestrictionButton(restrictions: $restrictions, restriction: .vegan)
                        RestrictionButton(restrictions: $restrictions, restriction: .vegetarian)
                    }
                    HStack{
                        RestrictionButton(restrictions: $restrictions, restriction: .pescatarian)
                        RestrictionButton(restrictions: $restrictions, restriction: .keto)
                    }
                    HStack{
                        RestrictionButton(restrictions: $restrictions, restriction: .glutenFree)
                        RestrictionButton(restrictions: $restrictions, restriction: .dairyFree)
                    }
                    HStack{
                        RestrictionButton(restrictions: $restrictions, restriction: .nutFree)
                        RestrictionButton(restrictions: $restrictions, restriction: .peanutFree)
                    }
                    HStack{
                        RestrictionButton(restrictions: $restrictions, restriction: .eggFree)
                        RestrictionButton(restrictions: $restrictions, restriction: .soyFree)
                    }
                    
                }
                .padding(.horizontal)
                .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.3), trigger: restrictions)
                
                Spacer()
            }
        }
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), action: {
                triggerHaptics.toggle()
                screenStep += 1
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

private struct SetupScreen: View {
    @Binding var screenStep: Int
    @Binding var isOnboardingComplete: Bool
    @Binding var triggerHaptics: Bool
    
    var body: some View {
        VStack {
            VStack{
                Image("mascot-happy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 140, height: 140)
                    .shadow(color: Color("primary").opacity(0.3), radius: 5)
                
                Text("All finished ___")
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
                triggerHaptics.toggle()
                isOnboardingComplete = true
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

private struct RestrictionButton: View {
    @Binding var restrictions: [Restriction: Bool]
    let restriction: Restriction
    var body: some View {
        Button {
            restrictions[restriction]?.toggle()
        } label: {
            Text(restriction.rawValue)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                .foregroundStyle(restrictions[restriction] == true ? Color("text3") : Color("text2"))
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(restrictions[restriction] == true ? Color("primary") : Color("background2"))
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(restrictions[restriction] == true ? Color("primary") : Color.clear)
                }
        }
    }
}

private struct TrendPoint: Identifiable {
    let id = UUID()
    let week: String
    let y: Double
}

#Preview{
    OnboardingView(isOnboardingComplete: .constant(false))
    
//    GoalScreen(screenStep: .constant(1))
//        .background(Color("background"))
}
