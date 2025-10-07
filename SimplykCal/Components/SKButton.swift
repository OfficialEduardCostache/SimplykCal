//
//  SKButton.swift
//  SimplykCal
//
//  Created by Eduard Costache on 01/10/2025.
//

import SwiftUI

struct SKButton: View {
    let title: String
    let isSelected: Bool
    var icon: Image?
    var alignment: Alignment?
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon{
                    icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 16, height: 16)
                        .foregroundStyle(isSelected ? Color("text3") : Color("text1"))
                }
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(isSelected ? Color("text3") : Color("text1"))
            }
            .padding(.horizontal, 14)
            .frame(height: 48)
            .frame(maxWidth: .infinity, alignment: alignment ?? .center)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isSelected ? Color("primary") : Color("background2"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(Color("primary"), lineWidth: 1)
            )
        }
    }
}

#Preview {
    SKButton(title: "meow", isSelected: false, icon: nil, alignment: .leading) {
        //
    }
}
