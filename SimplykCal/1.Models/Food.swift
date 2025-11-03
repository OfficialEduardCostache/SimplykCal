//
//  Food.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/10/2025.
//

import SwiftData
import SwiftUI
import Foundation

@Model
class Food{
    var name: String
    var calories: Double
    var protein: Double
    var fats: Double
    var carbs: Double
    var dateAdded: Date
    
    var isServing: Bool
    var quantity: Double
    
    init(name: String, calories: Double, protein: Double, fats: Double, carbs: Double, dateAdded: Date, isServing: Bool, quantity: Double) {
        self.name = name
        self.calories = calories
        self.protein = protein
        self.fats = fats
        self.carbs = carbs
        self.dateAdded = dateAdded
        self.isServing = isServing
        self.quantity = quantity
    }
}

//MARK: Custom Predicates for SwiftData
extension Food {
    static func onDay(_ day: Date = Date.now, calendar: Calendar = .current) -> Predicate<Food> {
        let start = calendar.startOfDay(for: day)
        let end   = calendar.date(byAdding: .day, value: 1, to: start)!
        return #Predicate<Food> { f in
            f.dateAdded >= start && f.dateAdded < end
        }
    }
}

//MARK: Testing
extension Food{
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
    
    static var testFoods: [Food] =
    [
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: false, quantity: 60),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: false, quantity: 60),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: true, quantity: 1),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: true, quantity: 2),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: true, quantity: 3),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: false, quantity: 60),
        Food(name: "Banana", calories: 122, protein: 10, fats: 0, carbs: 20, dateAdded: Date.now, isServing: false, quantity: 60)
    ]
}
