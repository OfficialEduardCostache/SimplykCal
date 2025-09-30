//
//  OnboardingViewModel.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/09/2025.
//

import Observation
import SwiftUI

@Observable
class OnboardingViewModel{
    // screen variables
    private(set) var screenStep: Int = 0
    var triggerSucessfulHaptic: Bool = false
    var triggerErrorHaptic: Bool = false
    let totalSteps: Int = 6
    let fadeDuration: Double = 0.4
    var fadeOpacity: Double = 0
    
    // user details
    var name: String = ""
    
    var age: Double = 25
    let ageRange: ClosedRange<Double> = 16...80
    
    var height: Double = 177
    let heightRange: ClosedRange<Double> = 120...250
    
    var weight: Double = 70
    let weightRange: ClosedRange<Double> = 35...105
    
    var gender: Gender? = nil
    
    var goal: Goal? = nil
    var paceForWeightLoss: Double = 50 {
        didSet { generateGraphPointsForLoss() }
    }

    var paceForWeightGain: Double = 50 {
        didSet { generateGraphPointsForGain() }
    }
    var graphData: [WeightGraphPoint] = []
    
    var restrictions: [Restriction] = []
    
    func decrementAge() { age = max(ageRange.lowerBound, age - 1) }
    func incrementAge() { age = min(ageRange.upperBound, age + 1) }
    
    func decrementHeight() { height = max(heightRange.lowerBound, height - 1) }
    func incrementHeight() { height = min(heightRange.upperBound, height + 1) }
    
    func decrementWeight() { weight = max(weightRange.lowerBound, weight - 1) }
    func incrementWeight() { weight = min(weightRange.upperBound, weight + 1) }
    
    func setScreenStepAnimated(_ newValue: Int) {
        guard newValue != screenStep else { return }
        withAnimation(.easeInOut(duration: fadeDuration)) { fadeOpacity = 1 }
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) { [weak self] in
            guard let self else { return }
            self.screenStep = newValue
            withAnimation(.easeInOut(duration: self.fadeDuration)) { self.fadeOpacity = 0 }
        }
    }
    
    func animatedScreenStepBinding() -> Binding<Int> {
        Binding(
            get: { self.screenStep },
            set: { [weak self] newValue in
                self?.setScreenStepAnimated(newValue)
            }
        )
    }
    
    func next()  { setScreenStepAnimated(screenStep + 1) }
    func back()  { setScreenStepAnimated(max(0, screenStep - 1)) }

    func generateGraphPointsForLoss() {
        graphData.removeAll()
        var value = weight
        let fraction = paceForWeightLoss / 100.0 / 100.0
        for num in 1...6 {
            let delta = value * fraction
            let newValue = value - delta
            graphData.append(WeightGraphPoint(week: "W\(num)", y: newValue))
            value = newValue
        }
    }
    
    func generateGraphPointsForGain() {
        graphData.removeAll()
        var value = weight
        let fraction = paceForWeightGain / 100.0 / 100.0
        for num in 1...6 {
            let delta = value * fraction
            let newValue = value + delta
            graphData.append(WeightGraphPoint(week: "W\(num)", y: newValue))
            value = newValue
        }
    }
    
    func generateNewUser() -> User{
        let newUser = User(
            name: name,
            age: age,
            height: height,
            weight: weight,
            gender: gender ?? .male,
            goal: goal ?? .lose,
            restrictions: restrictions)
        
        return newUser
    }
}

// Validation
extension OnboardingViewModel{
    func validateUserName() -> String?{
        if name.count < 3 || name.count > 16{
            return ErrorTypes.nameTooLongOrTooShort.rawValue
        }

        return nil
    }
    
    func validateGender() -> String?{
        if gender == nil{
            return ErrorTypes.noGenderSelected.rawValue
        }
        
        return nil
    }
    
    func validateGoal() -> String?{
        if goal == nil{
            return ErrorTypes.noGoalSelected.rawValue
        }
        
        return nil
    }
}



struct WeightGraphPoint: Identifiable {
    let id = UUID()
    let week: String
    let y: Double
}

enum ErrorTypes: String{
    case nameTooLongOrTooShort = "Your name must be between 3 and 16 characters long"
    case noGenderSelected = "You need to select a gender to continue"
    case noGoalSelected = "You need to select a goal to continue"
}

