//
//  FoodHistoryCard.swift
//  SimplykCal
//
//  Created by Eduard Costache on 27/05/2025.
//

import SwiftUI

struct FoodHistoryCard: View {
    let dummyTime: String = "12:34"
    
    var body: some View {
        HStack{
            // FOOD LOG TIME
            Text(dummyTime)
                .font(.system(size: 14, weight: .medium, design: .monospaced))
                .foregroundStyle(Color("text1"))
            
            // SEPARATOR
            Rectangle()
                .frame(width: 12, height: 1)
                .foregroundColor(Color("text1"))
            
            // MAIN CONTENT
            FoodItemCard()
        }
    }
}

#Preview{
    ZStack{
        FoodHistoryCard()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("background").ignoresSafeArea(.all))
}
