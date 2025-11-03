//
//  HomeViewModel.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/10/2025.
//

import Observation
import SwiftUI

@Observable
class HomeViewModel{
    var user: User
    var showFoodHistoryExpandedSheet: Bool = false
    
    private var caloriesConsumedToday: Double = 1000
    private var proteinConsumedToday: Double = 20
    private var fatsConsumedToday: Double = 20
    private var carbsConsumedToday: Double = 20
    
    
    init(mockData: Bool = false, user: User?){
        if mockData{
            self.user = HomeViewModelUtil.testUser
        }
        else{
            self.user = user ?? HomeViewModelUtil.testUser
        }
    }
    
    func triggerFoodHistoryExpandedSheet(){
        showFoodHistoryExpandedSheet.toggle()
    }
}

//MARK: Macro functions
extension HomeViewModel{
    func getRemainingCalories() -> Double {
        let targetCalories = self.getMacroTarget(macroType: .calories)
        let remainingCalories = targetCalories - self.getConsumedMacro(macroType: .calories)
        
        return remainingCalories
    }
    
    func getMacroTarget(macroType macro: MacroType) -> Double {
        var target: Double = 0
        
        switch macro {
        case .calories:
            target = user.macros.calories
        case .protein:
            target = user.macros.protein
        case .carbs:
            target = user.macros.fats
        case .fat:
            target = user.macros.carbs
        }
        
        return target
    }
    
    func getConsumedMacro(macroType macro: MacroType) -> Double {
        switch macro {
        case .calories:
            return self.caloriesConsumedToday
        case .protein:
            return self.proteinConsumedToday
        case .carbs:
            return self.fatsConsumedToday
        case .fat:
            return self.carbsConsumedToday
        }
    }
    
    func updateConsumedMacro(macroType macro: MacroType, newValue: Double) {
        switch macro {
        case .calories:
            self.caloriesConsumedToday = newValue
        case .protein:
            self.proteinConsumedToday = newValue
        case .carbs:
            self.carbsConsumedToday = newValue
        case .fat:
            self.fatsConsumedToday = newValue
        }
    }
}

struct HomeViewModelUtil{
    static var testUser = User(
        name: "Test User",
        birthday: Calendar.current.date(from: .init(year: 2000, month: 6, day: 22))!,
        height: 177,
        weight: 70,
        gender: .male,
        activity: .moderate,
        goal: .maintain,
        bmr: 1650,
        tdee: 2300,
        macros: Macros(calories: 2200, protein: 140, fats: 60, carbs: 220),
        macroSplit: MacroSplit(protein: 0.28, fat: 0.27, carbs: 0.45),
        expectedEndDate: .now,
        carbFatBalance: .balanced,
        proteinIntake: .high
    )
    
    static var iconImages: [Image] =
    [
        Image("dairy"),
        Image("eggs"),
        Image("fruits"),
        Image("grains"),
        Image("nuts"),
        Image("plate-and-cutlery"),
        Image("seeds"),
        Image("vegetables"),
        Image("chicken"),
        Image("beef"),
        Image("pork"),
        Image("fish"),
        Image("shrimp"),
        Image("legumes"),
        Image("bakery"),
        Image("butter"),
        Image("coffee"),
        Image("corn"),
        Image("dairy-alternatives"),
        Image("drinks"),
        Image("oils"),
        Image("sauces"),
        Image("spices"),
        Image("supplements"),
        Image("sweet-potato"),
        Image("sweets-and-snacks"),
        Image("turkey")
    ]
}
