//
//  ValidationError.swift
//  SimplykCal
//
//  Created by Eduard Costache on 24/06/2025.
//

import SwiftUI

struct ValidationError: View {
    var message: String
    
    var body: some View {
        HStack {
            Image(systemName: "exclamationmark.circle")
                .foregroundColor(Color.red.opacity(0.8))
            Text(message)
                .foregroundColor(Color.red.opacity(0.8))
            
            Spacer()
        }
    }
}
