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
    @Previewable @State var previewVM: HomeViewModel = HomeViewModel(mockData: true, user: nil)
    VStack{
        
        ForEach(makeRandomFoods(count: 5, date: .now)) { food in
            FoodItemCard(
                foodName: food.name,
                calories: food.calories,
                protein: food.protein,
                fats: food.fats,
                carbs: food.carbs,
                dateAdded: food.dateAdded,
                isServing: food.isServing,
                quantity: food.quantity,
                icon: HomeViewModelUtil.iconImages[2],
                showTime: true,
                showAddIcon: false)
        }
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: .infinity)
    .background(
        Color("background").ignoresSafeArea()
    )
}

func makeRandomFoods(count: Int = 5, date: Date = .now) -> [Food] {
    (0..<count).map { i in
        // random grams
        let protein = Double.random(in: 0...999).rounded()
        let fats    = Double.random(in: 0...999).rounded()
        let carbs   = Double.random(in: 0...999).rounded()
        
        // kcal from macros (4/9/4 rule)
        let calories = Double.random(in: 0...9999).rounded()
        
        let choice = Int.random(in: 1...2)
        
        var quantity: Double{
            if choice == 1{
                return Double.random(in: 1...9999).rounded()
            }
            else{
                return Double.random(in: 1...99).rounded()
            }
        }
        
        return Food(
            name: "Random Food \(i+1)",
            calories: calories.rounded(),
            protein: protein,
            fats: fats,
            carbs: carbs,
            dateAdded: date,
            isServing: choice == 1 ? false : true,
            quantity: quantity
        )
    }
}



