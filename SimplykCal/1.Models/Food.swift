//
//  Food.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/10/2025.
//

import SwiftData
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
