//
//  SKSlider.swift
//  SimplykCal
//
//  Created by Eduard Costache on 06/09/2025.
//
import SwiftUI

struct SKSlider: View{
    @Binding var value: Int
    let range: ClosedRange<Int>
    
    var unit: String? = nil
    
    private let stepWidth: CGFloat = 20
    
    @State private var tempValue: Int
    @State private var dragOffset: CGFloat = 0

    init(value: Binding<Int>, range: ClosedRange<Int>, unit: String? = nil) {
        self._value = value
        self.range = range
        self.unit = unit
        self._tempValue = State(initialValue: value.wrappedValue)
        self._dragOffset = State(initialValue: 0)
    }

    var body: some View{
        VStack(spacing: 8) {
        
        Text("\(tempValue)")
            .font(.system(size: 32, weight: .bold, design: .monospaced))
            .contentTransition(.numericText())
            .foregroundStyle(Color("text1"))

        if let unit = unit{
            Text(unit)
                .font(.system(size: 16, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color.gray)
            }

            VStack {
                GeometryReader{ geometry in
                    let center = geometry.size.width / 2
                    
                    ForEach(range, id: \.self) { tick in
                        let x = center + CGFloat(tick - value) * stepWidth + dragOffset
                        
                        VStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(tick == tempValue ? Color.white : Color.gray.opacity(0.4))
                                .frame(width: tick == tempValue ? 3 : 1, height: tick % 5 == 0 ? 20 : 10)
                            
                            Text("\(tick)")
                                .font(.system(size: 16, weight: .regular, design: .monospaced))
                                .foregroundStyle(tick % 5 == 0 ? Color("text1") : Color.clear)
                                .offset(y: 10)
                        }
                        .position(x: x, y: geometry.size.height/2)
                    }
                }
                .frame(height: 80)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { gesture in
                            withAnimation(.interactiveSpring){
                                
                                let rawOffset = gesture.translation.width
                                let offsetSteps = rawOffset / stepWidth
                                var projected = CGFloat(value) - offsetSteps
                                let lower = CGFloat(range.lowerBound)
                                let upper = CGFloat(range.upperBound)
                                
                                if projected < lower {
                                    let overshoot = lower - projected
                                    projected = lower - log(overshoot + 1) * 2
                                }
                                else if projected > upper {
                                    let overshoot = projected - upper
                                    projected = upper + log(overshoot + 1) * 2
                                }
                                
                                dragOffset = (CGFloat(value) - projected) * stepWidth
                                let rounded = Int(projected.rounded())
                                tempValue = rounded.clamped(to: range)
                                
                            }
                        }
                        .onEnded { gesture in
                            let offsetSteps = gesture.translation.width / stepWidth
                            let finalValue = Int((CGFloat(value) - offsetSteps).rounded()).clamped(to: range)
                            withAnimation(.interpolatingSpring(stiffness: 120, damping: 20)) {
                                value = finalValue
                                tempValue = finalValue
                                dragOffset = 0
                            }
                        }
                )
            }
        }
    }
}

extension Comparable{
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}


#Preview {
    SKSliderPreview()
}

private struct SKSliderPreview: View {
    @State private var value: Int = 70
    private let range: ClosedRange<Int> = 40...120

    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            SKSlider(value: $value,
                     range: range,
                     unit: "kg")
            .padding(24)
        }
        .preferredColorScheme(.dark)
    }
}
