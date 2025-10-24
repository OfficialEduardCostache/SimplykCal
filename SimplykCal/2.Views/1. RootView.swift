//
//  ContentView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 23/05/2025.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @State var tabBarViewModel: TabBarViewModel = TabBarViewModel()
    @State var previewVM = OnboardingViewModel(mockData: true)
    
    @Query var users: [User]
    
    var body: some View {
//        if let user = users.first{
//            ZStack {
//                switch tabBarViewModel.selectedTab {
//                case 0: HomeView(tabBarViewModel: tabBarViewModel)
//                case 1: SimplyView()
//                case 2: StatisticsView()
//                case 3: SettingsView()
//                default: HomeView(tabBarViewModel: tabBarViewModel)
//                }
//            }
//            .safeAreaInset(edge: .bottom) {
//                CustomTabBar(tabBarViewModel: tabBarViewModel)
//                    .offset(y: tabBarViewModel.isShowing ? 0 : 150)
//                    .opacity(tabBarViewModel.isShowing ? 1 : 0)
//                    .animation(.easeInOut, value: tabBarViewModel.isShowing)
//            }
//            .sheet(isPresented: $tabBarViewModel.showAddFoodSheet, onDismiss: {
//                tabBarViewModel.showAddFoodSheet = false
//            }) {
//                FoodSheet()
//                    .presentationDetents([.fraction(0.95)])
//                    .presentationDragIndicator(.visible)
//            }
//        }
//        else{
//            OnboardingView()
//        }

        OnboardingView()
    }
}

#Preview {
    RootView()
        .ignoresSafeArea(edges: .bottom)
}
