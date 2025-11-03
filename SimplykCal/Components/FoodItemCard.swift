//
//  FoodItemCard.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI

struct FoodItemCard: View {
    let foodName: String
    let calories: Double
    let protein: Double
    let fats: Double
    let carbs: Double
    
    let dateAdded: Date
    
    let isServing: Bool
    let quantity: Double
    
    let icon: Image
    
    let showTime: Bool
    let showAddIcon: Bool
    
    var body: some View {
        HStack(spacing: 4) {
            if showTime{
                Text("\(DateFormattingUtil.formattedTime(from: dateAdded))")
                    .font(.system(size: 12, weight: .light, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .padding(12)
                    .frame(maxHeight: 70)
                    .background(
                        UnevenRoundedRectangle(cornerRadii: .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 0, topTrailing: 0))
                            .fill(Color("background3"))
                    )
                
            }
            
            HStack(spacing: 16){
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                
                
                VStack(alignment: .leading){
                    HStack {
                        Text(foodName)
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        Spacer()
                        
                        Text(String(format: isServing ? "%.0f servings" : "%.0fg", quantity))
                            .font(.system(size: 12, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    
                    HStack{
                        MacroSection(macroType: .calories, macroAmount: calories)
                        MacroSection(macroType: .protein, macroAmount: protein)
                        MacroSection(macroType: .fat, macroAmount: fats)
                        MacroSection(macroType: .carbs, macroAmount: carbs)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
            .padding()
            .frame(maxWidth: 360, maxHeight: 70)
            .background(
                UnevenRoundedRectangle(cornerRadii: .init(topLeading: showTime ? 0 : 10, bottomLeading: showTime ? 0 : 10, bottomTrailing: 10, topTrailing: 10))
                    .fill(Color("background3"))
            )
        }
        .padding(.horizontal, 8)
    }
}

struct MacroSection: View {
    let macroType: MacroType
    let macroAmount: Double
    
    var imageName: String = ""
    
    var body: some View {
        HStack{
            Image(macroType == .calories ? "calories" : macroType == .protein ? "protein" : macroType == .fat ? "fats" : "carbs")
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
            
            Text(String(format: "%.0f", macroAmount))
                .font(.system(size: 14, weight: .ultraLight, design: .monospaced))
                .foregroundStyle(Color("text2"))
                .minimumScaleFactor(0.5)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview {
    VStack{
        ForEach(Food.testFoods){ food in
            FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, isServing: food.isServing, quantity: food.quantity, icon: Food.iconImages[2], showTime: true, showAddIcon: false)
        }
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: .infinity)
    .background(
        Color("background").ignoresSafeArea()
    )
}



