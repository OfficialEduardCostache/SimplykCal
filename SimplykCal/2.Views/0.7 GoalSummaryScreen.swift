//
//  0.7 GoalSummaryScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 07/10/2025.
//

import SwiftUI

struct GoalSummaryScreen: View {
    @Binding var viewModel: OnboardingViewModel
    
    var body: some View {
        VStack{
            ScrollView{
                if let goal = viewModel.goal{
                    //MARK: Weight Card
                    SummaryCard(
                        leading: "\(goal.rawValue.capitalized) Weight",
                        description: "This is your goal. We want to make sure that you get to your goal, and to do that, you have to stick to it. Simply will make sure you get there, you just have to follow through. you can do this!") {
                            HStack(spacing: 2){
                                Text(String(format: "%.1f", viewModel.weight))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                                
                                Text("kg")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text2"))
                            }
                            
                            Image(systemName: "arrow.right")
                                .font(.system(size: 16, weight: .bold, design: .monospaced))
                                .foregroundStyle(Color("text2"))
                            
                            HStack(spacing: 2){
                                Text(String(format: "%.1f", viewModel.targetWeight))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                                
                                Text("kg")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text2"))
                            }
                        }
                    
                    //MARK: Calories Card
                    SummaryCard(
                        leading: "Daily Calories",
                        description: "To stay on track to your goal, these are the calories you must be consuming each day. Try and stay as close to this number as possible.") {
                            HStack(spacing: 2){
                                Text(String(format: "%.0f", viewModel.dailyCalories))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                                
                                Text("kcal")
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text2"))
                            }
                        }
                    
                    if goal != .maintain{
                        //MARK: Goal Speed Card
                        SummaryCard(
                            leading: "Goal Speed",
                            description: "This is the rate of your goal. The higher the %, the faster you will achieve your goal. It is recommended to stay within the limits we have provided.") {
                                HStack(spacing: 2) {
                                    Text(String(format: "%.2f", viewModel.weeklyPercentage))
                                        .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                        .foregroundStyle(Color("text1"))
                                    
                                    
                                    Text("%BW")
                                        .font(.system(size: 16, weight: .bold, design: .monospaced))
                                        .foregroundStyle(Color("text2"))
                                }
                                
                                Text("per Week")
                                    .font(.system(size: 16, weight: .semibold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                            }
                        
                        //MARK: End Date Card
                        SummaryCard(
                            leading: "End Date",
                            description: "Depending on your goal weight and the goal speed, we have provided you with an estimated end date for reaching your goal. This date is realistic if you stay on track to your daily calories. It can also increase if your activity drops, or decrease if your activity increases.") {
                                Text(viewModel.formatDate(date: viewModel.expectedEndDate))
                                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                                    .foregroundStyle(Color("text1"))
                            }
                    }
                }
                else{
                    EmptyView()
                }
            }
            Spacer()
        }
        //MARK: Next Button
        .safeAreaInset(edge: .bottom) {
            SKActionButton(title: "Next", fillColour: Color("primary"), isDisabled: false, action: {
                viewModel.triggerSucessfulHaptic.toggle()
                viewModel.next()
            })
            .padding()
            .padding(.bottom, 40)
        }
    }
}

private struct SummaryCard<Content: View>: View {
    let leading: String
    let description: String?
    @ViewBuilder let trailing: () -> Content
    
    init(
        leading: String,
        description: String? = nil,
        @ViewBuilder trailing: @escaping () -> Content
    ) {
        self.leading = leading
        self.description = description
        self.trailing = trailing
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(leading)
                    .font(.system(size: 16, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                Spacer()
                trailing()
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(
                UnevenRoundedRectangle(
                    cornerRadii: description != nil
                    ? .init(topLeading: 10, topTrailing: 10)
                    : .init(topLeading: 10, bottomLeading: 10, bottomTrailing: 10, topTrailing: 10)
                )
                .fill(Color("background3"))
            )
            
            if let description {
                Text(description)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(Color("text2"))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(
                        UnevenRoundedRectangle(cornerRadii: .init(bottomLeading: 10, bottomTrailing: 10))
                            .fill(Color("background2"))
                    )
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 6)
    }
}

#Preview {
    @Previewable @State var previewVM = OnboardingViewModel(mockData: true)
    ZStack {
        Color("background").ignoresSafeArea()
        GoalSummaryScreen(viewModel: $previewVM)
    }
}
