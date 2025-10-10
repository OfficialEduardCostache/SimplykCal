//
//  SKTextField.swift
//  SimplykCal
//
//  Created by Eduard Costache on 29/08/2025.
//


import SwiftUI

struct SKTextField: View {
    let title: String?
    let placeholder: String
    @Binding var text: String
    let icon: String?
    var errorMessage: String?
    let trailingText: String?

    @FocusState private var focused: Bool

    init(title: String? = nil,
         placeholder: String = "",
         text: Binding<String>,
         icon: String? = nil,
         errorMessage: String? = nil,
         trailingText: String? = nil) {
        self.title = title
        self.placeholder = placeholder
        self._text = text
        self.icon = icon
        self.errorMessage = errorMessage
        self.trailingText = trailingText
    }

    private var borderColor: Color {
        if errorMessage != nil { return Color.red }
        return focused ? Color("primary") : Color("text2").opacity(0.2)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // LABEL
            if let title {
                Text(title)
                    .font(.system(size: 14, weight: .semibold, design: .monospaced))
                    .foregroundStyle(Color("text2"))
            }

            // FIELD CONTAINER
            HStack(spacing: 10) {
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundStyle(focused ? Color("text1") : Color("text2"))
                        .frame(width: 18)
                }
                
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color("text2").opacity(0.5)).font(.system(size: 14, weight: .regular, design: .monospaced)))
                    .foregroundStyle(Color("text1")) // typed text color
                    .focused($focused)
                    .fontDesign(.monospaced)
                
                if let trailingText {
                    Text(trailingText)
                        .font(.system(size: 14, weight: .semibold, design: .monospaced))
                        .foregroundStyle(Color("text2"))
                }
                
            }
            .padding(.horizontal, 14)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color("background2"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .stroke(borderColor, lineWidth: 1)
            )
            .shadow(color: focused ? Color("primary").opacity(0.1) : .clear,
                    radius: focused ? 14 : 0, x: 0, y: 6)
            .animation(.easeInOut(duration: 0.18), value: focused)
            .animation(.easeInOut(duration: 0.18), value: errorMessage)

            // ERROR HANDLING
            if let errorMessage {
                Text(errorMessage)
                    .font(.system(size: 12, weight: .regular, design: .monospaced))
                    .foregroundStyle(Color.red)
            }
        }
    }
}

#Preview{
    ZStack {
        Color("background").ignoresSafeArea()
        VStack(spacing: 20) {
            SKTextField(title: "name", placeholder: "", text: .constant(""), errorMessage: nil)
            SKTextField(title: "name", placeholder: "", text: .constant(""), errorMessage: nil)
        }
        .padding(20)
    }
}
