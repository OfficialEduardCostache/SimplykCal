//
//  6.2 SearchScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI

struct SearchScreen: View {
    @State var searchText: String = ""
    @Binding var showFoodDetailsSheet: Bool
    
    var body: some View {
        VStack{
            SKTextField(placeholder: "Search for food...", text: $searchText)
            
            VStack{
                Text("Your favourites")
                    .font(.system(size: 14, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ScrollView(.horizontal){
                    HStack{
                        ForEach(0..<20) { _ in
                            FoodFavouriteCard()
                                .onTapGesture {
                                    showFoodDetailsSheet = true
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.bottom)
            
            Text("Other foods")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView{
                let foods = HomeViewModelUtil.foodInDatabase
                ForEach(foods, id: \.self) { food in
                    FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: false, showAddIcon: true)
                        .onTapGesture {
                            showFoodDetailsSheet = true
                        }
                }
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview {
    @Previewable @State var showFoodDetailsSheet: Bool = false
    
    SearchScreen(showFoodDetailsSheet: $showFoodDetailsSheet)
        .background(Color("background"))
}
