//
//  SKSlider.swift
//  SimplykCal
//
//  Created by Eduard Costache on 06/09/2025.
//
import SwiftUI

struct SKSlider: View{
    @Binding var value: Double
    let range: ClosedRange<Double>
    let unitOfMeasure: String?
    let step: Double

    // Layout
    private let stepWidth: CGFloat = 20

    // Internal UI state
    @State private var tempValue: Double
    @State private var dragOffset: CGFloat = 0

    init(
        value: Binding<Double>,
        range: ClosedRange<Double>,
        step: Double = 0.5,
        unitOfMeasure: String? = nil
    ) {
        self._value = value
        self.range = range
        self.step = step
        self.unitOfMeasure = unitOfMeasure
        self._tempValue = State(initialValue: value.wrappedValue)
        self._dragOffset = State(initialValue: 0)
    }

    var body: some View{
        VStack {
            // Value + unit label
            HStack(alignment: .bottom, spacing: 0){
                Text(formattedTempValue)
                    .font(.system(size: 18, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color("text1"))
                    .contentTransition(.numericText(value: tempValue))

                if let unitOfMeasure = unitOfMeasure{
                    Text(unitOfMeasure)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                }
            }

            GeometryReader{ geometry in
                let center = geometry.size.width / 2

                if step.isWholeNumber {
                    ForEach(Int(range.lowerBound)...Int(range.upperBound), id: \.self) { intIndex in
                        let tick = Double(intIndex)
                        let x = center + CGFloat(tick - value) * stepWidth + dragOffset
                        let isMajor = (intIndex % 5 == 0)
                        let isSelected = Int(tempValue.rounded()) == intIndex

                        VStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isSelected ? Color("text1") : Color("text2").opacity(0.5))
                                .frame(width: isSelected ? 3 : 1, height: isMajor ? 20 : 10)
                        }
                        .position(x: x, y: geometry.size.height/2)
                    }
                } else {

                    ForEach(Int(range.lowerBound * 2)...Int(range.upperBound * 2), id: \.self) { halfIndex in
                        let tick = Double(halfIndex) / 2.0
                        let x = center + CGFloat(tick - value) * stepWidth + dragOffset
                        let isWhole = (halfIndex % 2 == 0)
                        let isSelected = Int((tempValue * 2).rounded()) == halfIndex

                        VStack{
                            Spacer()
                            RoundedRectangle(cornerRadius: 10)
                                .fill(isSelected ? Color("text1") : Color("text2").opacity(0.5))
                                .frame(width: isSelected ? 3 : 1, height: isWhole ? 20 : 10)
                        }
                        .position(x: x, y: geometry.size.height/2)
                    }
                }
            }
            .frame(height: 30)
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { gesture in
                        withAnimation(.interactiveSpring){
                            let rawOffset = gesture.translation.width
                            let offsetUnits = rawOffset / stepWidth // 1 unit = 1.0 value
                            var projected = value - Double(offsetUnits)
                            let lower = range.lowerBound
                            let upper = range.upperBound

                            if projected < lower {
                                let overshoot = lower - projected
                                projected = lower - log(overshoot + 1) * 2
                            }
                            else if projected > upper {
                                let overshoot = projected - upper
                                projected = upper + log(overshoot + 1) * 2
                            }

                            dragOffset = CGFloat(value - projected) * stepWidth
                            let snapped = projected.snapped(to: step).clamped(to: range)
                            tempValue = snapped
                        }
                    }
                    .onEnded { gesture in
                        let offsetUnits = gesture.translation.width / stepWidth
                        let projected = value - Double(offsetUnits)
                        let finalValue = projected.snapped(to: step).clamped(to: range)
                        withAnimation(.interpolatingSpring(stiffness: 120, damping: 20)) {
                            value = finalValue
                            tempValue = finalValue
                            dragOffset = 0
                        }
                    }
            )
        }
        .clipped()
        .padding()
    }
}

private extension Double {
    var isWholeNumber: Bool { truncatingRemainder(dividingBy: 1) == 0 }
    func snapped(to step: Double) -> Double {
        guard step > 0 else { return self }
        return (self / step).rounded() * step
    }
}


private extension SKSlider {
    var formattedTempValue: String {
        if step < 1 { return String(format: "%.1f", tempValue) }
        if step.isWholeNumber { return String(format: "%.0f", tempValue) }
        return String(tempValue)
    }
}

private extension Comparable{
    func clamped(to limits: ClosedRange<Self>) -> Self {
        return min(max(self, limits.lowerBound), limits.upperBound)
    }
}

#Preview {
    SKSliderPreview()
}

private struct SKSliderPreview: View {
    @State private var value: Double = 70
    private let range: ClosedRange<Double> = 40...120

    var body: some View {
        ZStack {
            Color("background").ignoresSafeArea()

            VStack(spacing: 24) {
                // 0.5 step (fractional): whole = big, halves = small
                SKSlider(value: $value, range: range, step: 0.5, unitOfMeasure: "kg")
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("background2"))
                    )

                // 1.0 step (whole): big every 5
                SKSlider(value: $value, range: range, step: 1.0, unitOfMeasure: "kg")
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color("background2"))
                    )
            }
            .padding()
        }
    }
}

