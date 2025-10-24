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
    var weight: Double = 70
    var gender: Gender? = nil
    var activity: ActivityLevel? = nil
    var goal: Goal? = nil
    var bmr: Double = 0
    var tdee: Double = 0
    var macros: Macros = Macros(calories: 0, protein: 0, fats: 0, carbs: 0)
    var expectedEndDate: Date = Date.now
    var carbFatBalance: CarbFatBalance? = nil
    var proteinIntake: ProteinIntake = .moderate
    var macroSplit: MacroSplit? = nil
    
    // constants
    let heightRange: ClosedRange<Double> = 130...210
    let weightRange: ClosedRange<Double> = 35...220
    private let caloriesPerGramProtein: Double = 4
    private let caloriesPerGramCarbs: Double = 4
    private let caloriesPerGramFat: Double = 9
    
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
            self.macros = Macros(calories: 200, protein: 150, fats: 100, carbs: 100)
            self.macroSplit = MacroSplit(protein: 0.5, fat: 0.3, carbs: 0.2)
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

    func generateNewUser() -> User{

        let newUser = User(
            name: self.name,
            birthday: self.birthday,
            height: self.height,
            weight: self.weight,
            gender: self.gender!,
            activity: self.activity!,
            goal: self.goal!,
            bmr: self.bmr,
            tdee: self.tdee,
            macros: self.macros,
            macroSplit: self.macroSplit!,
            expectedEndDate: self.expectedEndDate,
            carbFatBalance: self.carbFatBalance!,
            proteinIntake: self.proteinIntake)
        
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
            self.macros.calories = self.tdee
            return
        }

        let dailyDifference = (self.weeklyWeight * 7700) / 7
        switch goal {
        case .lose: self.macros.calories = self.tdee - dailyDifference
        case .gain: self.macros.calories = self.tdee + dailyDifference
        default:    self.macros.calories = self.tdee
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

//MARK: Macro function
extension OnboardingViewModel{
    func updateProteinIntake(selectionAsSliderValue: Double){
        switch selectionAsSliderValue{
        case 0:
            self.proteinIntake = .low
        case 1:
            self.proteinIntake = .moderate
        case 2:
            self.proteinIntake = .high
        case 3:
            self.proteinIntake = .extraHigh
        default:
            self.proteinIntake = .moderate
        }
    }
    
    func calculateMacroDistribution() {
        switch (carbFatBalance, proteinIntake) {
            
        case (.balanced, .low):        self.macroSplit = MacroSplit(protein: 0.20, fat: 0.30, carbs: 0.50)
        case (.balanced, .moderate):   self.macroSplit = MacroSplit(protein: 0.25, fat: 0.30, carbs: 0.45)
        case (.balanced, .high):       self.macroSplit = MacroSplit(protein: 0.30, fat: 0.25, carbs: 0.45)
        case (.balanced, .extraHigh):  self.macroSplit = MacroSplit(protein: 0.35, fat: 0.25, carbs: 0.40)
            
        case (.lowFat, .low):          self.macroSplit = MacroSplit(protein: 0.20, fat: 0.20, carbs: 0.60)
        case (.lowFat, .moderate):     self.macroSplit = MacroSplit(protein: 0.25, fat: 0.20, carbs: 0.55)
        case (.lowFat, .high):         self.macroSplit = MacroSplit(protein: 0.30, fat: 0.20, carbs: 0.50)
        case (.lowFat, .extraHigh):    self.macroSplit = MacroSplit(protein: 0.35, fat: 0.20, carbs: 0.45)
            
        case (.lowCarb, .low):         self.macroSplit = MacroSplit(protein: 0.20, fat: 0.40, carbs: 0.40)
        case (.lowCarb, .moderate):    self.macroSplit = MacroSplit(protein: 0.25, fat: 0.40, carbs: 0.35)
        case (.lowCarb, .high):        self.macroSplit = MacroSplit(protein: 0.30, fat: 0.40, carbs: 0.30)
        case (.lowCarb, .extraHigh):   self.macroSplit = MacroSplit(protein: 0.35, fat: 0.40, carbs: 0.25)
            
        case (.keto, .low):            self.macroSplit = MacroSplit(protein: 0.15, fat: 0.75, carbs: 0.10)
        case (.keto, .moderate):       self.macroSplit = MacroSplit(protein: 0.20, fat: 0.70, carbs: 0.10)
        case (.keto, .high):           self.macroSplit = MacroSplit(protein: 0.25, fat: 0.65, carbs: 0.10)
        case (.keto, .extraHigh):      self.macroSplit = MacroSplit(protein: 0.30, fat: 0.60, carbs: 0.10)
        case (.none, _):
            self.macroSplit = MacroSplit(protein: 0.25, fat: 0.30, carbs: 0.45)
        }
        
        calculateAndUpdateMacros()
    }
    
    func calculateAndUpdateMacros() {
        if let macroSplit = self.macroSplit{
            let proteinP = macroSplit.protein
            let fatP = macroSplit.fat
            let carbsP = macroSplit.carbs
            
            self.macros.protein = (self.macros.calories * proteinP) / caloriesPerGramProtein
            self.macros.fats = (self.macros.calories * fatP) / caloriesPerGramFat
            self.macros.carbs = (self.macros.calories * carbsP) / caloriesPerGramCarbs
        }
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


