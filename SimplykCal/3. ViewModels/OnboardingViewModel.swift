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
    var expectedEndDate: Date = Date.now
    
    var weeklyWeight: Double = 0.0
    var weeklyPercentage: Double = 0.5 {
        didSet {
            updateWeeklyMontlyVariables()
            calculateNewCalories()
            updateExpectedEndDate()
        }
    }
    var monthlyWeight: Double = 0.0
    var monthlyPercentage: Double = 0.0
    
    var targetWeight: Double = 0 {
        didSet {
            updateExpectedEndDate()
        }
    }
    
    init(mockData: Bool = false) {
        if mockData {
            self.name = "Eduard"
            self.gender = .male
            self.activity = .moderate
            self.goal = .lose
            self.weight = 67
            self.targetWeight = 67
            self.dailyCalories = 2500
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
    
    func next(){
        if self.screenStep == 4 && self.goal == .maintain{
            setScreenStepAnimated(6)
        }
        else{
            setScreenStepAnimated(screenStep + 1)
        }
    }
    func back(){
        if self.screenStep == 6 && self.goal == .maintain{
            setScreenStepAnimated(4)
        }
        else{
            setScreenStepAnimated(max(0, screenStep - 1))
        }

    }

    func isGoalSummaryScreen() -> Bool{
        print("screen step 7")
        return screenStep == 7
    }
  
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
    
    func formatDate(date: Date) -> String{
        date.formatted(.dateTime.day().month(.wide).year())
    }
    
    func getYearsFromBirthday() -> Double {
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: Date())
        return Double(ageComponents.year ?? 0)
    }
    
    func dateByAdding(days: Int, to date: Date) -> Date {
        Calendar.current.date(byAdding: .day, value: days, to: date) ?? date
    }
    
    func updateExpectedEndDate(){
        guard weeklyWeight > 0 else {
            self.expectedEndDate = Date.now
            return
        }
        
        if self.weight > self.targetWeight{
            let differenceInWeight: Double = self.weight - self.targetWeight
            let daysToTargetWeight: Int = Int((differenceInWeight / self.weeklyWeight) * 7)
            
            self.expectedEndDate = dateByAdding(days: daysToTargetWeight, to: Date.now)
        }
        else if self.weight < self.targetWeight{
            let differenceInWeight: Double = self.targetWeight - self.weight
            let daysToTargetWeight: Int = Int((differenceInWeight / self.weeklyWeight) * 7)
            
            self.expectedEndDate = self.dateByAdding(days: daysToTargetWeight, to: Date.now)
        }
        else{
            self.expectedEndDate = Date.now
        }
    }
}

//MARK: Calorie Functions
extension OnboardingViewModel{
    func calculateBMR() {
        let age = getYearsFromBirthday()

        self.bmr = 10 * self.weight + 6.25 * self.height - 5 * age

        switch gender {
        case .male:   bmr += 5
        case .female: bmr -= 161
        case .none:   print("ERROR: Gender is nil in calculateBMR()")
        }
    }
    
    func calculateTDEE(){
        switch activity{
        case .sedentary:
            self.tdee = self.bmr * 1.2
        case .light:
            self.tdee = self.bmr * 1.375
        case .moderate:
            self.tdee = self.bmr * 1.55
        case .veryActive:
            self.tdee = self.bmr * 1.725
        case .extremelyActive:
            self.tdee = self.bmr * 1.9
        case .none:
            print("ERROR: function 'calculateTDEE()' activity is nil")
        }
    }
    
    func calculateNewCalories() {
        guard self.weeklyWeight > 0 else {
            self.dailyCalories = self.tdee
            return
        }

        let dailyDifference = (self.weeklyWeight * 7700) / 7
        switch goal {
        case .lose: self.dailyCalories = self.tdee - dailyDifference
        case .gain: self.dailyCalories = self.tdee + dailyDifference
        default:    self.dailyCalories = self.tdee
        }
    }
    
    func updateWeeklyMontlyVariables() {
        self.weeklyWeight = (self.weeklyPercentage / 100) * self.weight
        
        self.monthlyWeight = self.weeklyWeight * 4
        self.monthlyPercentage = self.weeklyPercentage * 4
    }
    
    func syncTargetWeight(){
        self.targetWeight = self.weight
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


