//
//  SKLabel.swift
//  SimplykCal
//
//  Created by Eduard Costache on 03/11/2025.
//

import SwiftUI

struct SKLabel: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 14, weight: .semibold, design: .monospaced))
            .foregroundStyle(Color("text2"))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
