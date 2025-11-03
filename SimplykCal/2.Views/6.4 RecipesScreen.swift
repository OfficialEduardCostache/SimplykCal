//
//  6.4 RecipesScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 14/09/2025.
//

import SwiftUI

struct RecipesScreen: View {
    @State var searchText: String = ""
    @Binding var showFoodDetailsSheet: Bool
    
    var body: some View {
        VStack{
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
            
            ScrollView{
                
            }
            .scrollIndicators(.hidden)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

