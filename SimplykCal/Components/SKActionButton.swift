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
    var isSelected: Bool?
    var action: () -> Void
    
    init(title: String, fillColour: Color, icon: Image? = nil, textSize: CGFloat = 18, isSelected: Bool = true, action: @escaping () -> Void) {
        self.title = title
        self.fillColour = fillColour
        self.icon = icon
        self.textSize = textSize
        self.isSelected = isSelected
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
                    .fill(fillColour.opacity(isSelected ?? true ? 1 : 0.12))
            )
        }
    }
}

#Preview {
    SKActionButton(title: "Test", fillColour: Color.red, icon: Image(systemName: "plus")) {
        //
    }
}
