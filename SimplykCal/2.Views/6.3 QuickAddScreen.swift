//
//  6.3 QuickAddScreen.swift
//  SimplykCal
//
//  Created by Eduard Costache on 02/09/2025.
//

import SwiftUI


struct QuickAddScreen: View {
    var body: some View {
        VStack{
            SKTextField(title: "Energy", text: .constant(""), trailingText: "kCal")
                .padding(.vertical, 20)
            
            HStack{
                SKTextField(title: "Protein", text: .constant(""), trailingText: "g")
                SKTextField(title: "Fat", text: .constant(""), trailingText: "g")
                SKTextField(title: "Carbs", text: .constant(""), trailingText: "g")
            }
            .padding(.bottom, 20)
            
            SKTextField(title: "Name", text: .constant(""))
            
            Spacer()
            
            SKActionButton(title: "Add", fillColour: Color("primary"), action: {
                
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}

#Preview{
    QuickAddScreen()
        .background(Color("background"))
}
