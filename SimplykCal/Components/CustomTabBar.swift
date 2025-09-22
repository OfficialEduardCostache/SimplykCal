//
//  CustomTabBar.swift
//  SimplykCal
//
//  Created by Eduard Costache on 29/05/2025.
//

import SwiftUI

struct CustomTabBar: View {
    @Bindable var tabBarViewModel: TabBarViewModel
    
    var body: some View {
        HStack {
            Spacer()
            RegularIcon(image: Image(systemName: "house"), isSelected: tabBarViewModel.selectedTab == 0) {
                tabBarViewModel.selectedTab = 0
            }
            Spacer()
            RegularIcon(image: Image("simply-icon"), isSelected: tabBarViewModel.selectedTab == 1) {
                tabBarViewModel.selectedTab = 1
            }
            Spacer()
            
            FloatingActionButton(systemName: "plus") {
                tabBarViewModel.showAddFoodSheet = true
            }
//            .offset(y:-38)
            
            Spacer()
            RegularIcon(image: Image(systemName: "chart.xyaxis.line"), isSelected: tabBarViewModel.selectedTab == 2) {
                tabBarViewModel.selectedTab = 2
            }
            Spacer()
            RegularIcon(image: Image(systemName: "gearshape"), isSelected: tabBarViewModel.selectedTab == 3) {
                tabBarViewModel.selectedTab = 3
            }
            Spacer()
        }
        .padding(.bottom, 40)
        .padding(4)
        .background(
            Color("background2")
        )
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.6), trigger: tabBarViewModel.selectedTab)
        .sensoryFeedback(.impact(flexibility: .solid, intensity: 0.6), trigger: tabBarViewModel.showAddFoodSheet)
    }
}

private struct RegularIcon: View {
    let image: Image
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            image
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 34, height: 34)
                .foregroundStyle(isSelected ? Color("primary") : Color("text2"))
        }
    }
}

private struct FloatingActionButton: View {
    let systemName: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .scaledToFit()
                .frame(width: 35, height: 35)
                .foregroundStyle(Color("primary"))
                .accessibilityLabel(Text(systemName))
                .padding(18)
                .background(
                    Circle()
                        .fill(Color("background3"))
                )

        }
    }
}

#Preview {
    @Previewable @State var tabBarViewModel: TabBarViewModel = TabBarViewModel()
    CustomTabBar(tabBarViewModel: tabBarViewModel)
}
