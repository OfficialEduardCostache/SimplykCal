//
//  FoodAddCard.swift
//  SimplykCal
//
//  Created by Eduard Costache on 16/09/2025.
//
import SwiftUI

struct FoodAddCard: View {
    var body: some View {
        HStack{
            FoodItemCard()
            
            Spacer()
            
            Image(systemName: "plus")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
                .foregroundStyle(Color("secondary"))
                .padding(.trailing, 20)
        }
        .frame(maxWidth: .infinity)
    }
}
