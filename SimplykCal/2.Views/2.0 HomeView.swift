//
//  HomeView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 31/05/2025.
//

import SwiftUI

struct HomeView: View {
    @Bindable var tabBarViewModel: TabBarViewModel
    
    @State var showFoodHistoryExpandedSheet: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                ProgressBarStack()
                FoodHistoryStack(showFoodHistoryExpandedSheet: $showFoodHistoryExpandedSheet)
                    .padding(.horizontal, 4)
                Spacer()
            }
            .sheet(isPresented: $showFoodHistoryExpandedSheet) {
                ExpandedFoodHistorySheet()
            }
        }
        .background(Color("background").ignoresSafeArea(edges: .all))
    }
}

private struct ProgressBarStack: View {
    var body: some View {
        VStack{
            HStack {
                VStack{
                    Text("100")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                    
                    Text("Remaining")
                        .font(.system(size: 16, weight: .light, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                }
                .frame(width: 90)
                
                // CALORIES PROGRESS BAR
                SKProgressBar(rawProgress: 100, goal: 1000, progressBarSize: .big, progressType: .calories)
                    .padding(.horizontal)
                
                VStack{
                    Text("1400")
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                    
                    Text("Target")
                        .font(.system(size: 16, weight: .light, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                }
                .frame(width: 90)
                
            }
            .padding()
            
            HStack{
                // PROTEIN PROGRESS BAR
                SKProgressBar(rawProgress: 100, goal: 150, progressBarSize: .medium, progressType: .protein)
                
                Spacer()
                
                // FAT PROGRESS BAR
                SKProgressBar(rawProgress: 50, goal: 110, progressBarSize: .medium, progressType: .fat)
                
                Spacer()
                
                // CARBS PROGRESS BAR
                SKProgressBar(rawProgress: 2, goal: 30, progressBarSize: .medium, progressType: .carbs)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
        }
    }
}

private struct FoodHistoryStack: View {
    @Binding var showFoodHistoryExpandedSheet: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // HEADER
            ZStack(alignment: .trailing){
                Text("Food for Today")
                    .font(.system(size: 16, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
                
                Button {
                    // scale up the food history
                    showFoodHistoryExpandedSheet = true
                } label: {
                    Image(systemName: "arrow.up.left.and.arrow.down.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .padding(.trailing)
                        .foregroundStyle(Color("text2"))
                }
            }

            ScrollView(.vertical) {
                LazyVStack(spacing: 8) {
                    ForEach(0..<50, id: \.self) { _ in
                        FoodHistoryCard()
                    }
                }
                .padding(.vertical, 8)
            }
            .scrollIndicators(.hidden)
            .clipShape(Rectangle())
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("background2"))
        )
        .frame(maxHeight: 350)
    }
}

#Preview {
    @Previewable var tabBarViewModel = TabBarViewModel()
    
    HomeView(tabBarViewModel: tabBarViewModel)
}
