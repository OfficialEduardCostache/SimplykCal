//
//  UserModel.swift
//  SimplykCal
//
//  Created by Eduard Costache on 30/09/2025.
//

import SwiftData

@Model
class User{
    var name: String
    var age: Double
    var height: Double
    var weight: Double
    
    private var genderRaw: String
    var gender: Gender {
        get { Gender(rawValue: genderRaw) ?? .male }
        set { genderRaw = newValue.rawValue }
    }
    
    private var goalRaw: String
    var goal: Goal {
        get { Goal(rawValue: goalRaw) ?? .maintain }
        set { goalRaw = newValue.rawValue }
    }
    
    private var restrictionsRaw: [String]
    var restrictions: [Restriction] {
        get { restrictionsRaw.compactMap(Restriction.init(rawValue:)) }
        set { restrictionsRaw = newValue.map(\.rawValue) }
    }
    
    init(name: String, age: Double, height: Double, weight: Double, gender: Gender, goal: Goal, restrictions: [Restriction]) {
        self.name = name
        self.age = age
        self.height = height
        self.weight = weight
        self.genderRaw = gender.rawValue
        self.goalRaw = goal.rawValue
        self.restrictionsRaw = restrictions.map(\.rawValue)
    }
}


enum Gender: String{
    case male = "Male"
    case female = "Female"
}

enum Goal: String{
    case lose = "Lose"
    case maintain = "Maintain"
    case gain = "Gain"
}

enum Restriction: String{
    case vegan = "Vegan"
    case vegetarian = "Vegetarian"
    case pescatarian = "Pescatarian"
    case keto = "Keto"
    case glutenFree = "Gluten-Free"
    case dairyFree = "Dairy-Free"
    case nutFree = "Nut-Free"
    case peanutFree = "Peanut-Free"
    case eggFree = "Egg-Free"
    case soyFree = "Soy-Free"
}
