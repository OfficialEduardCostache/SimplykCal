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
    let totalSteps: Int = 9
    let fadeDuration: Double = 0.4
    var fadeOpacity: Double = 0
    
    // user details
    var name: String = ""
    var birthday: Date = Calendar.current.date(from: DateComponents(year: 2000, month: 6, day: 22))!
    var height: Double = 177
    let heightRange: ClosedRange<Double> = 130...210
    var weight: Double = 70
    let weightRange: ClosedRange<Double> = 35...220
    var gender: Gender? = nil
    var activity: ActivityLevel? = nil
    var goal: Goal? = nil
    var restrictions: [Restriction] = []
    var bmr: Double = 0
    var tdee: Double = 0
    var dailyCalories: Double = 0
    
    var targetWeight: Double = 0
    
    init(mockData: Bool = false) {
        if mockData {
            self.name = "Eduard"
            self.gender = .male
            self.activity = .moderate
            self.goal = .gain
            self.weight = 67
            self.height = 174
            self.birthday = Calendar.current.date(from: DateComponents(year: 2000, month: 6, day: 22))!
        }
    }
    
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
  
    func handleRestrictionSelection(restriction: Restriction) {
        if let index = restrictions.firstIndex(of: restriction){
            restrictions.remove(at: index)
        }
        else{
            restrictions.append(restriction)
        }
    }
    
    func generateNewUser() -> User{
        let newUser = User(
            name: name,
            birthday: birthday,
            height: height,
            weight: weight,
            gender: gender ?? .male,
            activity: activity ?? .sedentary,
            goal: goal ?? .lose,
            restrictions: restrictions)
        
        return newUser
    }
    
    func formetDate(date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMMM yyyy"  // 👈 e.g. "22 June 2000"
        formatter.locale = Locale(identifier: "en_US_POSIX")  // ensures consistent month names

        let formattedDate = formatter.string(from: date)
        
        return formattedDate
    }
    
    func getYearsFromBirthday() -> Double {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return Double(ageComponents.year ?? 0)
    }
}

//MARK: Calorie Functions
extension OnboardingViewModel{
    func calculateBMR() {
        let age = getYearsFromBirthday()

        bmr = 10 * weight + 6.25 * height - 5 * age

        switch gender {
        case .male:   bmr += 5
        case .female: bmr -= 161
        case .none:   print("ERROR: Gender is nil in calculateBMR()")
        }
    }
    
    func calculateTDEE(){
        switch activity{
        case .sedentary:
            tdee = bmr * 1.2
        case .light:
            tdee = bmr * 1.375
        case .moderate:
            tdee = bmr * 1.55
        case .veryActive:
            tdee = bmr * 1.725
        case .extremelyActive:
            tdee = bmr * 1.9
        case .none:
            print("ERROR: function 'calculateTDEE()' activity is nil")
        }
    }
    
    func calculateCalorieDeficit(kgPerWeek: Double){
        let dailyDeficit: Double = (kgPerWeek * 7700) / 7
        
        dailyCalories = tdee - dailyDeficit
    }
    
    func calculateCalorieSurplus(kgPerWeek: Double){
        let dailySurplus: Double = (kgPerWeek * 7700) / 7
        
        dailyCalories = tdee + dailySurplus
    }
}

// Validation
extension OnboardingViewModel{
    func isUsernameValid() -> Bool{
        if name.count < 3 || name.count > 16{
            return false
        }

        return true
    }
    
    func isGenderValid() -> Bool{
        if gender == nil{
            return false
        }
        
        return true
    }
    
    func isActivityValid() -> Bool{
        if activity == nil{
            return false
        }
        return true
    }
    
    func validateGoal() -> String?{
        if goal == nil{
            return ErrorTypes.noGoalSelected.rawValue
        }
        
        return nil
    }
    
    func validateActivity() -> String?{
        if activity == nil{
            return ErrorTypes.noActivitySelected.rawValue
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
    case noActivitySelected = "You need to select an activity level to continue"
}


