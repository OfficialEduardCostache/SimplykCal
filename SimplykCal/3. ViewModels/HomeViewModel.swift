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
    
    private var foodConsumedToday: [Food] = []
    
    init(mockData: Bool = false, user: User?){
        if mockData{
            self.user = HomeViewModelUtil.testUser
            self.foodConsumedToday = HomeViewModelUtil.mockFoodConsumedToday
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

//MARK: Food functions
extension HomeViewModel{
    func getFoodConsumedToday() -> [Food]{
        return self.foodConsumedToday
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
    
    static var mockFoodConsumedToday: [Food] = [
        Food(name: "Banana",          calories: 105, protein: 1.3,  fats: 0.3, carbs: 27,  dateAdded: .now),
        Food(name: "Greek Yogurt",    calories: 130, protein: 23,   fats: 0.4, carbs: 6,   dateAdded: .now),
        Food(name: "Chicken Breast",  calories: 220, protein: 42,   fats: 4,   carbs: 0,   dateAdded: .now),
        Food(name: "Rice (200g)",    calories: 260, protein: 5,    fats: 0.6, carbs: 57,  dateAdded: .now),
        Food(name: "Olive Oil (10g)",calories: 90,  protein: 0,    fats: 10,  carbs: 0,   dateAdded: .now)
    ]
    
    static var foodInDatabase: [Food] = [
        Food(name: "Grilled Chicken Breast", calories: 165, protein: 31, fats: 3.6, carbs: 0, dateAdded: .now),
        Food(name: "Brown Rice (1 cup)", calories: 216, protein: 5, fats: 1.8, carbs: 45, dateAdded: .now),
        Food(name: "Avocado (1 medium)", calories: 240, protein: 3, fats: 22, carbs: 12, dateAdded: .now),
        Food(name: "Salmon Fillet", calories: 206, protein: 22, fats: 12, carbs: 0, dateAdded: .now),
        Food(name: "Banana", calories: 105, protein: 1.3, fats: 0.3, carbs: 27, dateAdded: .now),
        Food(name: "Greek Yogurt (200g)", calories: 120, protein: 20, fats: 0.4, carbs: 7, dateAdded: .now),
        Food(name: "Whole Egg", calories: 70, protein: 6, fats: 5, carbs: 0.5, dateAdded: .now),
        Food(name: "Peanut Butter (2 tbsp)", calories: 190, protein: 8, fats: 16, carbs: 6, dateAdded: .now),
        Food(name: "Apple", calories: 95, protein: 0.5, fats: 0.3, carbs: 25, dateAdded: .now),
        Food(name: "Oatmeal (1 cup cooked)", calories: 155, protein: 6, fats: 3, carbs: 27, dateAdded: .now)
    ]
    
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
