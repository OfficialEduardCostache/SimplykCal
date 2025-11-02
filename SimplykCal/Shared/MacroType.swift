//
//  ProgressType.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/05/2025.
//

import SwiftUI

enum MacroType {
    case calories, protein, carbs, fat
    
    var angularGradient: AngularGradient {
        switch self {
        case .calories:
            return AngularGradient(colors: [Color(hex: "FF7B00"), Color(hex: "C10000")], center: .center, startAngle: .degrees(180), endAngle: .degrees(360))
        case .protein:
            return AngularGradient(colors: [Color(hex: "20A4F3"), Color(hex: "22577A")], center: .center, startAngle: .degrees(180), endAngle: .degrees(360))
        case .carbs:
            return AngularGradient(colors: [Color(hex: "60efff"), Color(hex: "00ff87")], center: .center, startAngle: .degrees(180), endAngle: .degrees(360))
        case .fat:
            return AngularGradient(colors: [Color(hex: "FFCF21"), Color(hex: "ff930f")], center: .center, startAngle: .degrees(180), endAngle: .degrees(360))
        }
    }
    
    var linearGradient: LinearGradient {
        switch self {
        case .calories:
            return LinearGradient(colors: [Color(hex: "FF7B00"), Color(hex: "C10000")], startPoint: .bottomLeading, endPoint: .topTrailing)
        case .protein:
            return LinearGradient(colors: [Color(hex: "20A4F3"), Color(hex: "22577A")], startPoint: .bottomLeading, endPoint: .topTrailing)
        case .carbs:
            return LinearGradient(colors: [Color(hex: "60efff"), Color(hex: "00ff87")], startPoint: .bottomLeading, endPoint: .topTrailing)
        case .fat:
            return LinearGradient(colors: [Color(hex: "FFCF21"), Color(hex: "ff930f")], startPoint: .bottomLeading, endPoint: .topTrailing)
        }
    }

    
    var image: Image {
        switch self {
        case .calories: return Image("calories")
        case .protein: return Image("protein")
        case .carbs: return Image("carbs")
        case .fat: return Image("fats")
        }
    }
    
    var name: String {
        switch self {
        case .calories: return "Calories"
        case .protein: return "Protein"
        case .carbs: return "Carbs"
        case .fat: return "Fat"
        }
    }
}
