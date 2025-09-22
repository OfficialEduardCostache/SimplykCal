//
//  FoodItemCard.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI

struct FoodItemCard: View {
    let dummyFoodName: String = "Banana"
    let dummyCalories: Double = 105
    let dummyCarbs: Double = 27
    let dummyProtein: Double = 1.4
    let dummyFat: Double = 0.4
    
    let iconImages: [Image] =
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
    
    var body: some View {
        HStack{
            iconImages.randomElement()!
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading){
                Text(dummyFoodName)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                
                HStack{
                    MacrosAmount(macroType: .calories, macroAmount: dummyCalories)
                    MacrosAmount(macroType: .protein, macroAmount: dummyProtein)
                    MacrosAmount(macroType: .fat, macroAmount: dummyFat)
                    MacrosAmount(macroType: .carbs, macroAmount: dummyCarbs)
                    
                    // Divider
                    Rectangle()
                        .frame(width: 1, height: 14)
                        .foregroundStyle(Color("text1").opacity(0.3))
                        .padding(.horizontal, 4)
                    
                    ServingAmount()
                }
            }
        }
        .padding(8)
        .background(
            Rectangle()
                .cornerRadius(6)
                .foregroundStyle(Color("background3"))
        )
    }
}

private struct MacrosAmount: View {
    
    let macroType: ProgressType
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
    ZStack{
        FoodItemCard()
    }
    .frame(maxWidth: .infinity)
    .frame(maxHeight: .infinity)
    .background(
        Color("background").ignoresSafeArea()
    )
}

