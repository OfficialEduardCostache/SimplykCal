//
//  6. FoodSheet.swift
//  SimplykCal
//
//  Created by Eduard Costache on 23/08/2025.
//

import SwiftUI

enum TabSelection{
    case scan
    case search
    case quickAdd
    case recipes
}

struct FoodSheet: View {
    @State var selectedTab: TabSelection = .scan
    @State var showFoodDetailsSheet = false

    var body: some View {
        VStack {
            SegmentedTabs(selectedTab: $selectedTab)
                .padding(.horizontal, 16)
            
            ZStack {
                switch selectedTab {
                case .scan:
                    ScanScreen()
                case .search:
                    SearchScreen(showFoodDetailsSheet: $showFoodDetailsSheet)
                case .quickAdd:
                    QuickAddScreen()
                case .recipes:
                    RecipesScreen(showFoodDetailsSheet: $showFoodDetailsSheet)
                }
            }
            .animation(.snappy, value: selectedTab)
        }
        .padding(.top, 32)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("background").ignoresSafeArea(.all))
        .sheet(isPresented: $showFoodDetailsSheet) {
            FoodDetailsSheet(showFoodDetailsSheet: $showFoodDetailsSheet)
                .presentationDetents([.fraction(0.95)])
                .presentationDragIndicator(.hidden)
                .interactiveDismissDisabled()
        }
    }
}

private struct SegmentedTabs: View {
    @Binding var selectedTab: TabSelection
    @Namespace private var selectionNS

    var body: some View {
        ScrollView(.horizontal){
            HStack(spacing: 8) {
                TabSegment(imageName: "barcode.viewfinder", text: "Scan",
                           isSelected: selectedTab == .scan,
                           ns: selectionNS) {
                    selectedTab = .scan
                }

                TabSegment(imageName: "magnifyingglass", text: "Search",
                           isSelected: selectedTab == .search,
                           ns: selectionNS) {
                    selectedTab = .search
                }

                TabSegment(imageName: "plus", text: "Quick Add",
                           isSelected: selectedTab == .quickAdd,
                           ns: selectionNS) {
                    selectedTab = .quickAdd
                }
                
                TabSegment(imageName: "book", text: "Recipes",
                           isSelected: selectedTab == .recipes,
                           ns: selectionNS) {
                    selectedTab = .recipes
                }
            }
            .padding(6)
            .animation(.snappy, value: selectedTab)
        }
        .overlay(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .stroke(Color("text2").opacity(0.2), lineWidth: 1)
        )
        .background(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color("background2"))
        )
        .scrollIndicators(.hidden)
    }
}

private struct TabSegment: View {
    let imageName: String
    let text: String
    let isSelected: Bool
    let ns: Namespace.ID
    var onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 6) {
                Image(systemName: imageName)
                    .font(.system(size: 14, weight: .semibold))
                Text(text)
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    
            }
            .frame(maxWidth: .infinity)
            .frame(height: 28)
            .padding(.vertical, 2)
            .padding(.horizontal, 6)
            .foregroundStyle(isSelected ? Color("text3") : Color("text2"))
            .background(
                Group {
                    if isSelected {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .fill(Color("primary"))
                            .matchedGeometryEffect(id: "SEGMENT_SELECTION", in: ns)
                    }
                }
            )
            .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    FoodSheet()
}
