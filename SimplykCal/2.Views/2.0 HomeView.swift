//
//  HomeView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 31/05/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Bindable var tabBarViewModel: TabBarViewModel
    @State var homeViewModel: HomeViewModel
    
    var body: some View {
        ZStack{
            VStack {
                ProgressBarStack(homeViewModel: $homeViewModel)
                FoodHistoryStack(homeViewModel: $homeViewModel)
                    .padding(.horizontal, 4)
                Spacer()
            }
            .sheet(isPresented: $homeViewModel.showFoodHistoryExpandedSheet) {
                ExpandedFoodHistorySheet(homeViewModel: $homeViewModel)
                    .presentationDetents([.fraction(0.8)])
            }
        }
        .background(Color("background").ignoresSafeArea(edges: .all))
    }
}

private struct ProgressBarStack: View {
    @Binding var homeViewModel: HomeViewModel
    var body: some View {
        VStack{
            HStack {
                VStack{
                    Text(String(format: "%.0f", homeViewModel.getRemainingCalories()))
                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                    
                    Text("Remaining")
                        .font(.system(size: 16, weight: .light, design: .monospaced))
                        .foregroundStyle(Color("text1"))
                }
                .frame(width: 90)
                
                // CALORIES PROGRESS BAR
                SKProgressBar(rawProgress: homeViewModel.getConsumedMacro(macroType: .calories), goal: homeViewModel.getMacroTarget(macroType: .calories), progressBarSize: .big, progressType: .calories)
                    .padding(.horizontal)
                
                VStack{
                    Text(String(format: "%.0f", homeViewModel.getMacroTarget(macroType: .calories)))
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
                SKProgressBar(rawProgress: homeViewModel.getConsumedMacro(macroType: .protein), goal: homeViewModel.getMacroTarget(macroType: .protein), progressBarSize: .medium, progressType: .protein)
                
                Spacer()
                
                // FAT PROGRESS BAR
                SKProgressBar(rawProgress: homeViewModel.getConsumedMacro(macroType: .fat), goal: homeViewModel.getMacroTarget(macroType: .fat), progressBarSize: .medium, progressType: .fat)
                
                Spacer()
                
                // CARBS PROGRESS BAR
                SKProgressBar(rawProgress: homeViewModel.getConsumedMacro(macroType: .carbs), goal: homeViewModel.getMacroTarget(macroType: .carbs), progressBarSize: .medium, progressType: .carbs)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 20)
            
        }
    }
}

private struct FoodHistoryStack: View {
    @Binding var homeViewModel: HomeViewModel
    @Query private var foods: [Food]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // HEADER
            ZStack(alignment: .trailing){
                Text("Food for Today")
                    .font(.system(size: 16, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 4)
                
                if foods.count > 1{
                    Button {
                        homeViewModel.triggerFoodHistoryExpandedSheet()
                    } label: {
                        Image(systemName: "arrow.up.left.and.arrow.down.right")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 16, height: 16)
                            .padding(.trailing)
                            .foregroundStyle(Color("text2"))
                    }
                }
            }
            
            if foods.count > 1{
                ScrollView(.vertical) {
                    LazyVStack(spacing: 8) {
                        ForEach(foods, id: \.self) { food in
                            FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: true, showAddIcon: false)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .scrollIndicators(.hidden)
                .clipShape(Rectangle())
            }
            else{
                VStack{
                    Image("mascot-searching")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                    
                    Text("No food today")
                        .font(.system(size: 18, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .center)
            }
            
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("background2"))
        )
        .frame(maxHeight: 350)
    }
}

struct ExpandedFoodHistorySheet: View{
    @Binding var homeViewModel: HomeViewModel
    @Query private var foods: [Food]
    
    var body: some View{
        VStack(alignment: .leading, spacing: 8) {
            ScrollView(.vertical) {
                LazyVStack(spacing: 8) {
                    ForEach(foods, id: \.self) { food in
                        FoodItemCard(foodName: food.name, calories: food.calories, protein: food.protein, fats: food.fats, carbs: food.carbs, dateAdded: food.dateAdded, icon: HomeViewModelUtil.iconImages.randomElement()!, showTime: true, showAddIcon: false)
                    }
                }
                .padding(.vertical, 8)
            }
            .scrollIndicators(.hidden)
            .clipShape(Rectangle())
        }
        .background(
            Color("background2").ignoresSafeArea(.all)
        )
    }
}

#Preview {
    @Previewable var tabBarViewModel = TabBarViewModel()
    @Previewable var previewVM: HomeViewModel = HomeViewModel(mockData: true, user: nil)
    
    HomeView(tabBarViewModel: tabBarViewModel, homeViewModel: previewVM)
}
