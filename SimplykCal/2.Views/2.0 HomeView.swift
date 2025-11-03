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
    var user: User
    @Query private var foods: [Food]
    
    init(tabBarViewModel: TabBarViewModel, user: User) {
        self.tabBarViewModel = tabBarViewModel
        self.user = user
        _foods = Query(
            filter: Food.onDay(),
            sort: [SortDescriptor(\.dateAdded, order: .reverse)]
        )
    }
    
    private var todayCalories: Double { foods.reduce(0) { $0 + $1.calories } }
    private var todayProtein:  Double { foods.reduce(0) { $0 + $1.protein  } }
    private var todayFats:     Double { foods.reduce(0) { $0 + $1.fats     } }
    private var todayCarbs:    Double { foods.reduce(0) { $0 + $1.carbs    } }
    
    @State var triggerExpandedFoodHistorySheet: Bool = false
    
    var body: some View {
        ZStack{
            VStack {
                VStack{
                    HStack {
                        VStack{
                            Text(String(format: "%.0f", todayCalories))
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                            
                            Text("Consumed")
                                .font(.system(size: 16, weight: .light, design: .monospaced))
                                .foregroundStyle(Color("text1"))
                        }
                        .frame(width: 90)
                        
                        // CALORIES PROGRESS BAR
                        SKProgressBar(rawProgress: todayCalories, goal: getTargetMacro(macroType: .calories), progressBarSize: .big, progressType: .calories)
                            .padding(.horizontal)
                        
                        VStack(spacing: 30){
                            VStack{
                                Text(String(format: "%.0f", getTargetMacro(macroType: .calories)))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                                
                                Text("Target")
                                    .font(.system(size: 16, weight: .light, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                            }
                            
                            VStack{
                                Text(String(format: "%.0f", getRemainingMacroForToday(macroType: .calories)))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                                
                                Text("Remaining")
                                    .font(.system(size: 16, weight: .light, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                            }
                        }
                        .frame(width: 90)
                        
                    }
                    .padding()
                    
                    HStack{
                        // PROTEIN PROGRESS BAR
                        SKProgressBar(rawProgress: todayProtein, goal: getTargetMacro(macroType: .protein), progressBarSize: .medium, progressType: .protein)
                        
                        Spacer()
                        
                        // FAT PROGRESS BAR
                        SKProgressBar(rawProgress: todayFats, goal: getTargetMacro(macroType: .fat), progressBarSize: .medium, progressType: .fat)
                        
                        Spacer()
                        
                        // CARBS PROGRESS BAR
                        SKProgressBar(rawProgress: todayCarbs, goal: getTargetMacro(macroType: .carbs), progressBarSize: .medium, progressType: .carbs)
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                    
                }
                
                VStack(spacing: 8) {
                    // HEADER
                    ZStack(alignment: .trailing){
                        Text("Food for Today")
                            .font(.system(size: 16, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 4)
                        
                        if foods.count > 1{
                            Button {
                                triggerExpandedFoodHistorySheet = true
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
                                ForEach(foods, id: \.persistentModelID) { food in
                                    FoodItemCard(
                                        foodName: food.name,
                                        calories: food.calories,
                                        protein: food.protein,
                                        fats: food.fats,
                                        carbs: food.carbs,
                                        dateAdded: food.dateAdded,
                                        isServing: food.isServing,
                                        quantity: food.quantity,
                                        icon: Food.iconImages[2],
                                        showTime: true,
                                        showAddIcon: false)
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
                
                
                Spacer()
            }
            .sheet(isPresented: $triggerExpandedFoodHistorySheet) {
                VStack(alignment: .leading, spacing: 8) {
                    ScrollView(.vertical) {
                        LazyVStack(spacing: 8) {
                            ForEach(foods, id: \.persistentModelID) { food in
                                FoodItemCard(
                                    foodName: food.name,
                                    calories: food.calories,
                                    protein: food.protein,
                                    fats: food.fats,
                                    carbs: food.carbs,
                                    dateAdded: food.dateAdded,
                                    isServing: food.isServing,
                                    quantity: food.quantity,
                                    icon: Food.iconImages[2],
                                    showTime: true,
                                    showAddIcon: false)
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
                
                .presentationDetents([.fraction(0.8)])
            }
        }
        .background(Color("background").ignoresSafeArea(edges: .all))
    }
}


//MARK: Logic
extension HomeView{
    private func getTargetMacro(macroType: MacroType) -> Double{
        switch macroType {
        case .calories:
            return user.macros.calories
        case .protein:
            return user.macros.protein
        case .carbs:
            return user.macros.fats
        case .fat:
            return user.macros.carbs
        }
    }
    
    private func getRemainingMacroForToday(macroType: MacroType) -> Double{
        switch macroType {
        case .calories:
            return max(getTargetMacro(macroType: .calories) - self.todayCalories, 0)
        case .protein:
            return getTargetMacro(macroType: .protein) - self.todayProtein
        case .carbs:
            return getTargetMacro(macroType: .fat) - self.todayFats
        case .fat:
            return getTargetMacro(macroType: .carbs) - self.todayCarbs
        }
    }
}


#Preview {
    @Previewable var tabBarViewModel = TabBarViewModel()
    @Previewable var previewUser = User.testUser
    
    HomeView(tabBarViewModel: tabBarViewModel, user: previewUser)
}


