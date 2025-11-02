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
    
    let icon: Image
    
    let showTime: Bool
    let showAddIcon: Bool
    
    var body: some View {
        HStack{
            if showTime{
                // FOOD LOG TIME
                Text(DateFormattingUtil.formattedTime(from: dateAdded))
                    .font(.system(size: 14, weight: .medium, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                
                // SEPARATOR
                Rectangle()
                    .frame(width: 6, height: 1)
                    .foregroundColor(Color("text1"))
            }
            
            HStack{
                icon
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading){
                    Text(foodName)
                        .font(.system(size: 14, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                    
                    HStack{
                        MacrosAmount(macroType: .calories, macroAmount: calories)
                        MacrosAmount(macroType: .protein, macroAmount: protein)
                        MacrosAmount(macroType: .fat, macroAmount: fats)
                        MacrosAmount(macroType: .carbs, macroAmount: carbs)
                        
                        // Divider
                        Rectangle()
                            .frame(width: 1, height: 14)
                            .foregroundStyle(Color("text1").opacity(0.3))
                            .padding(.horizontal, 4)
                        
                        ServingAmount()
                    }
                }
            }
            .frame(maxWidth: 310)
            .padding(8)
            .background(
                Rectangle()
                    .cornerRadius(6)
                    .foregroundStyle(Color("background3"))
            )
            
            if showAddIcon{
                Spacer()
                
                Image(systemName: "plus")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 16, height: 16)
                    .foregroundStyle(Color("secondary"))
                    .padding(.trailing, 20)
            }
        }
    }
}

private struct MacrosAmount: View {
    
    let macroType: MacroType
    let macroAmount: Double
    
    var body: some View {
        HStack(spacing: 0){
            macroType.image
                .resizable()
                .scaledToFit()
                .frame(width: 14, height: 14)
                .padding(.trailing, 4)
            
            Text(String(format: "%.0f", macroAmount))
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundStyle(Color("text2"))
        }
    }
}

private struct ServingAmount: View {
    var body: some View {
        Text("1 serving")
            .font(.system(size: 14, weight: .regular, design: .rounded))
            .foregroundStyle(Color("text2"))
    }
}

#Preview {
    @Previewable @State var previewVM: HomeViewModel = HomeViewModel(mockData: true, user: nil)
    VStack{
        let food = Food(name: "Olive Oil (10g)",calories: 111,  protein: 111,    fats: 111,  carbs: 111,   dateAdded: .now)
        
        FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: false, showAddIcon: true)
        
        FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: false, showAddIcon: true)
        
        FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: false, showAddIcon: true)
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: .infinity)
    .background(
        Color("background").ignoresSafeArea()
    )
}

