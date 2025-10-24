//
//  TestingUSer.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/10/2025.
//

import SwiftUI

struct TestingUSer: View {
    let user: User
    var body: some View {
        ScrollView{
            Text(user.name)
            Text(user.birthday.description)
            Text(user.height.description)
            Text(user.weight.description)
            Text(user.gender.rawValue)
            Text(user.activity.rawValue)
            Text(user.goal.rawValue)
            Text(user.bmr.description)
            Text(user.tdee.description)
            Text("User Macros")
            Text("  \(user.macros.calories)kcal")
            Text("  \(user.macros.protein)g")
            Text("  \(user.macros.fats)g")
            Text("  \(user.macros.carbs)g")
            Text("User Macro Split")
            Text("  \(user.macroSplit.protein)")
            Text("  \(user.macroSplit.fat)")
            Text("  \(user.macroSplit.carbs)")
            Text(user.expectedEndDate.description)
            Text(user.carbFatBalance.rawValue)
            Text(user.proteinIntake.rawValue)
        }
    }
}
