//
//  6.3 QuickAddScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI

struct QuickAddScreen: View {
    @Environment(\.modelContext) private var context
    
    @State var calories: String = ""
    @State var protein: String = ""
    @State var fat: String = ""
    @State var carbs: String = ""
    @State var name: String = ""
    
    var body: some View {
        VStack{
            SKTextField(title: "Energy", text: $calories, trailingText: "kCal")
                .padding(.vertical, 20)
                .keyboardType(.decimalPad)
            
            HStack{
                SKTextField(title: "Protein", text: $protein, trailingText: "g")
                    .keyboardType(.decimalPad)
                SKTextField(title: "Fat", text: $fat, trailingText: "g")
                    .keyboardType(.decimalPad)
                SKTextField(title: "Carbs", text: $carbs, trailingText: "g")
                    .keyboardType(.decimalPad)
            }
            .padding(.bottom, 20)
            
            SKTextField(title: "Name", text: $name)
            
            Spacer()
            
            SKActionButton(title: "Add", fillColour: Color("primary"), action: {
                let newFood = Food(name: name, calories: Double(calories) ?? 0, protein: Double(protein) ?? 0, fats: Double(fat) ?? 0, carbs: Double(carbs) ?? 0, dateAdded: Date.now)
                
                context.insert(newFood)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview{
    QuickAddScreen()
        .background(Color("background"))
}
