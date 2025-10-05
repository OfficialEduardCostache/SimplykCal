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
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundStyle(isSelected ? Color("text3") : Color("text1"))
            }
            .padding(.horizontal, 14)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
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
