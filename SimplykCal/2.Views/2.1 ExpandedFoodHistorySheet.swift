//
//  2.1 Ex[andedFoodHistorySheet.swift
//  SimplykCal
//
//  Created by Eduard Costache on 19/09/2025.
//

import SwiftUI

struct ExpandedFoodHistorySheet: View{
    var body: some View{
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.vertical) {
                LazyVStack(spacing: 8) {
                    ForEach(0..<50, id: \.self) { _ in
                        FoodHistoryCard()
                    }
                }
                .padding(.vertical, 8)
            }
            .scrollIndicators(.visible)
        }
        .background(
           Color("background2").ignoresSafeArea(.all)
        )
    }
}
