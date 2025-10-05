//
//  StyledButton.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/05/2025.
//

import SwiftUI

struct SKActionButton: View {
    let title: String
    let fillColour: Color
    let icon: Image?
    let textSize: CGFloat?
    var isDisabled: Bool?
    var action: () -> Void
    
    init(title: String, fillColour: Color, icon: Image? = nil, textSize: CGFloat = 18, isDisabled: Bool = false, action: @escaping () -> Void) {
        self.title = title
        self.fillColour = fillColour
        self.icon = icon
        self.textSize = textSize
        self.isDisabled = isDisabled
        self.action = action
    }

    var body: some View {
        Button(action: action) {
            HStack{
                if let icon = icon {
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 32, height: 32)
                        .foregroundStyle(Color("text3"))
                }
                
                Text(title)
                    .font(.system(size: textSize ?? 18, weight: .bold, design: .monospaced))
                    .foregroundColor(Color("text3"))
                    .padding()
                    
            }
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(fillColour.opacity(isDisabled ?? false ? 0.12 : 1))
            )
        }
        .disabled(isDisabled ?? false)
    }
}

#Preview {
    SKActionButton(title: "Test", fillColour: Color.red, icon: Image(systemName: "plus")) {
        //
    }
    
    SKActionButton(title: "test", fillColour: .orange, isDisabled: true) {
        //
    }
}
