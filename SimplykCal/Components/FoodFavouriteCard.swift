//
//  FoodFavouriteCard.swift
//  SimplykCal
//
//  Created by Eduard Costache on 19/09/2025.
//

import SwiftUI

struct FoodFavouriteCard: View{
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
    
    var body: some View{
        VStack{
            iconImages.randomElement()!
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 40)
            
            Text("Banana")
                .font(.system(size: 14, weight: .light, design: .monospaced))
                .foregroundStyle(Color("text2"))
        }
        .frame(maxWidth: 70)
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color("background3"))
        )
    }
}

#Preview{
    ScrollView(.horizontal){
        HStack{
            ForEach(0..<20) { _ in
                FoodFavouriteCard()
            }
        }
    }
    .background(
        Color("background2")
    )
}
