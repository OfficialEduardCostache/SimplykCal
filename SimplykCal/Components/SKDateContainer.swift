//
//  SKDateContainer.swift
//  SimplykCal
//
//  Created by Eduard Costache on 03/11/2025.
//
import SwiftUI

struct SKDateContainer: View {
    var dateString: String
    
    var body: some View {
        HStack{
            Text(dateString)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
                .foregroundStyle(Color("text1"))
                .padding(.vertical)
                .padding(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(systemName: "chevron.down")
                .padding(.trailing)
                .font(.system(size: 14, weight: .semibold, design: .monospaced))
        }
        .frame(maxWidth: .infinity)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("background2"))
        )
        .overlay {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("background3"), lineWidth: 4)
        }
    }
}
