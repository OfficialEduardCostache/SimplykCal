//
//  6.5 FoodDetailSheet.swift
//  SimplykCal
//
//  Created by Eduard Costache on 16/09/2025.
//

import SwiftUI

struct FoodDetailsSheet: View {
    @Binding var showFoodDetailsSheet: Bool
    @State var foodAmount: String = ""
    
    let dummyCalories: Double = 105.0
    let dummyProtein: Double = 1.3
    let dummyFat: Double = 0.4
    let dummyCarbs: Double = 27
    
    var body: some View {
        VStack{
            HStack{
                Button {
                    showFoodDetailsSheet = false
                } label: {
                    Image(systemName: "multiply")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 14, height: 14)
                        .foregroundStyle(Color("text2"))
                        .padding()
                        .background(
                            Capsule()
                                .fill(Color("background2"))
                        )
                }

                
                Button {
                    // CHANGE DATE OF LOG
                } label: {
                    VStack(){
                        Text("5 PM")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text1"))

                        
                        Text("Tomorrow")
                            .font(.system(size: 14, weight: .regular, design: .monospaced))
                            .foregroundStyle(Color("text2"))
                        
                    }
                    .frame(width: 100, height: 30)
                    .padding(8)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color("background2"))
                    )
                }

                
                Text("Banana")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity)
            }
            .padding(.top)
            .padding(.horizontal)
            
            HStack{
                MacroLabel(type: .calories, amount: dummyCalories)
                    .padding(.trailing, 40)
                
                
                HStack{
                    MacroLabel(type: .protein, amount: dummyProtein)
                    Spacer()
                    MacroLabel(type: .fat, amount: dummyFat)
                    Spacer()
                    MacroLabel(type: .carbs, amount: dummyCarbs)
                }
                .frame(maxWidth: .infinity)
            }
            .padding()
            
            Text("Impact on macros")
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            
            HStack(spacing: 20){
                SKProgressBar(rawProgress: 1401, goal: 1640, progressBarSize: .small, progressType: .calories, futureIncrement: dummyCalories)
                SKProgressBar(rawProgress: 149, goal: 151, progressBarSize: .small, progressType: .protein, futureIncrement: dummyProtein)
                SKProgressBar(rawProgress: 68, goal: 96, progressBarSize: .small, progressType: .fat, futureIncrement: dummyFat)
                SKProgressBar(rawProgress: 12, goal: 42, progressBarSize: .small, progressType: .carbs, futureIncrement: dummyCarbs)
            }
            .padding()

            Spacer()
            
            HStack{
                SKTextField(text: .constant("123"))
                SKTextField(text: .constant("123"))
                SKTextField(text: .constant("123"))
            }
            .padding(.horizontal)
            
            SKTextField(text: $foodAmount)
                .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            Color("background").ignoresSafeArea(.all)
        )
    }
}

private struct MacroLabel: View {
    let type: ProgressType
    let amount: Double
    
    var body: some View {
        VStack{
            type.image
                .resizable()
                .scaledToFit()
                .frame(width: type == .calories ? 26 : 22, height: type == .calories ? 26 : 22)
            
            if type == .calories{
                Text(String(format: "%.0f", amount))
                    .font(.system(size: type == .calories ? 26 : 22, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
            }
            else{
                Text(String(format: "%.1fg", amount))
                    .font(.system(size: type == .calories ? 26 : 22, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
            }
            
            Text(type.name)
                .font(.system(size: type == .calories ? 18 : 14, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text2"))
        }
    }
}

#Preview{
    FoodDetailsSheet(showFoodDetailsSheet: .constant(true))
}
