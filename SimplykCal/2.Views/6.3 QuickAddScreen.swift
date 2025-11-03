//
//  6.3 QuickAddScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI

struct QuickAddScreen: View {
    @Environment(\.modelContext) private var context
    @Binding var showAddFoodSheet: Bool
    
    @State private var calories: String = ""
    @State private var protein: String = ""
    @State private var fat: String = ""
    @State private var carbs: String = ""
    @State private var name: String = ""
    
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    
    var body: some View {
        VStack{
            VStack(spacing: 12) {
                SKTextField(title: "Energy", text: $calories, trailingText: "kCal")
                    .keyboardType(.decimalPad)
                    .onChange(of: calories) { oldValue, newValue in
                        validateDigitsAndSeparator(value: $calories, oldValue: oldValue, newValue: newValue)
                    }
            }
            .padding()
            
            
            HStack{
                SKTextField(title: "Protein", text: $protein, trailingText: "g")
                    .keyboardType(.decimalPad)
                SKTextField(title: "Fat", text: $fat, trailingText: "g")
                    .keyboardType(.decimalPad)
                SKTextField(title: "Carbs", text: $carbs, trailingText: "g")
                    .keyboardType(.decimalPad)
            }
            .padding()
            
            SKTextField(title: "Name", text: $name)
                .padding()
            
            Spacer()
            
            SKActionButton(title: "Add", fillColour: Color("primary"), isDisabled: calories.isEmpty, action: {
                
                // validating the macros
                guard let newCalories = parseStringMacroToDouble(macro: calories) else{
                    isError = true
                    errorMessage = "Please input a valid calorie amount"
                    return
                }
                
                guard let newProtein = parseStringMacroToDouble(macro: protein) else{
                    isError = true
                    errorMessage = "Please input a valid protein amount"
                    return
                }
                
                guard let newFat = parseStringMacroToDouble(macro: fat) else{
                    isError = true
                    errorMessage = "Please input a valid fat amount"
                    return
                }
                
                guard let newCarbs = parseStringMacroToDouble(macro: carbs) else{
                    isError = true
                    errorMessage = "Please input a valid carbs amount"
                    return
                }
                
                var newName = ""
                
                // validating the name
                if name.isEmpty{
                    newName = "Quick Add"
                }
                else{
                    newName = name
                }
                
                // adding the food
                let newFood = Food(
                    name: newName,
                    calories: newCalories,
                    protein: newProtein,
                    fats: newFat,
                    carbs: newCarbs,
                    dateAdded: Date.now,
                    isServing: true,
                    quantity: 1)
                context.insert(newFood)
                
                try? context.save()
                
                // closing the screen
                showAddFoodSheet = false
            })
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .alert("Input Error", isPresented: $isError) {
            Button("Okay") {
                isError = false
            }
        } message: {
            Text(errorMessage)
        }

    }
}

//MARK: Logic
extension QuickAddScreen{
    private func parseStringMacroToDouble(macro: String) -> Double?{
        if macro.isEmpty{
            return 0.0
        }
        
        guard let value = Double(macro) else{
            return nil
        }
        
        return value
    }
    
    private func validateDigitsAndSeparator(value: Binding<String>, oldValue: String, newValue: String){
        let sep: Character = "."
        var sepCount = 0
        var digitsBeforeSep = 0
        var digitsAfterSep = -1
        
        for c in newValue{
            if c == sep{
                sepCount += 1
            }
            
            if sepCount == 1{
                digitsAfterSep += 1
            }
            else if sepCount > 1{
                value.wrappedValue = oldValue
                break
            }
            else{
                digitsBeforeSep += 1
            }
        }
        
        if digitsBeforeSep > 5{
            value.wrappedValue = oldValue
            return
        }
        
        if digitsAfterSep > 2{
            value.wrappedValue = oldValue
            return
        }
    }
}

#Preview{
    QuickAddScreen(showAddFoodSheet: .constant(false))
        .background(Color("background"))
}
