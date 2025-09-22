//
//  Untitled.swift
//  SimplykCal
//
//  Created by Eduard Costache on 23/05/2025.
//

import SwiftUI

enum ProgressBarSize{
    case big
    case medium
    case small
    
    var scale: Double{
        switch self{
        case .small:
            return 0.6
        case .medium:
            return 0.85
        case.big:
            return 1.1
        }

    }
}

struct SKProgressBar: View {
    var rawProgress: Double
    var goal: Double
    let progressBarSize: ProgressBarSize
    let progressType: ProgressType
    var futureIncrement: Double?

    
    let x: CGFloat = 125
    let y: CGFloat = 125
    let baseLineWidth: CGFloat = 10

    private var processedProgress: Double {
        min(rawProgress / goal, 1.0) * 0.75
    }
    
    var body: some View {
        VStack {
            ZStack {
                // OUTLINE
                Circle()
                    .trim(from: 0, to: 0.75)
                    .rotation(Angle(degrees: 135))
                    .stroke(style: StrokeStyle(lineWidth: baseLineWidth * progressBarSize.scale * 1.8, lineCap: .round))
                    .frame(width: x * progressBarSize.scale, height: y * progressBarSize.scale)
                    .foregroundStyle(Color("background2"))
                
                // INCREMENT INDICATOR
                if let futureIncrement{
                    Circle()
                        .trim(from: 0, to: min((futureIncrement + rawProgress) / goal, 1.0) * 0.75)
                        .rotation(Angle(degrees: 135))
                        .stroke(style: StrokeStyle(lineWidth: baseLineWidth * progressBarSize.scale, lineCap: .round))
                        .frame(width: x * progressBarSize.scale, height: y * progressBarSize.scale)
                        .foregroundStyle(Color("success"))
                        .animation(.easeInOut(duration: 1), value: processedProgress)
                }
                
                // PROGRESS CIRCLE
                Circle()
                    .trim(from: 0, to: processedProgress)
                    .rotation(Angle(degrees: 135))
                    .stroke(style: StrokeStyle(lineWidth: baseLineWidth * progressBarSize.scale, lineCap: .round))
                    .frame(width: x * progressBarSize.scale, height: y * progressBarSize.scale)
                    .foregroundStyle(progressType.angularGradient)
                    .animation(.easeInOut(duration: 1), value: processedProgress)
                

                if progressBarSize == .big || progressBarSize == .medium{
                    // ICON
                    progressType.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60 * progressBarSize.scale, height: 60 * progressBarSize.scale)
                }
                else{
                    VStack{
                        Text(String(format: "%.0f%%", rawProgress/goal * 100))
                            .font(.system(size: 14, weight: .semibold, design: .monospaced))
                            .foregroundStyle(Color("text1"))
                        
                        if let futureIncrement{
                            Text(String(format: "+%.0f%%", futureIncrement/goal * 100))
                                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                                .foregroundStyle(Color("success"))
                        }
                    }
                    
                }
            }
            
            if progressBarSize == .medium{
                Text(progressType.name)
                    .font(.system(size: 14, weight: .light, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                
                Text("\(Int(rawProgress))/\(Int(goal))")
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .lineLimit(1)
            }
            else if progressBarSize == .small{
                Text(progressType.name)
                    .font(.system(size: 14, weight: .light, design: .monospaced))
                    .foregroundStyle(Color("text1"))
            }
        }
    }
}

#Preview {
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
        
        HStack(spacing: 20){
            SKProgressBar(rawProgress: 50, goal: 100, progressBarSize: .small, progressType: .calories, futureIncrement: 25)
            SKProgressBar(rawProgress: 50, goal: 100, progressBarSize: .small, progressType: .protein, futureIncrement: 25)
            SKProgressBar(rawProgress: 50, goal: 100, progressBarSize: .small, progressType: .fat, futureIncrement: 25)
            SKProgressBar(rawProgress: 50, goal: 100, progressBarSize: .small, progressType: .carbs, futureIncrement: 25)
        }
        .padding()
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(Color("background").ignoresSafeArea(.all))
}

