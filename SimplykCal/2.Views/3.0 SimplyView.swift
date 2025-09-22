//
//  3.0 SimplyView.swift
//  SimplykCal
//
//  Created by Eduard Costache on 25/08/2025.
//
import SwiftUI

struct SimplyView: View {
    @State private var messages: [ChatMessage] = [
        .init(role: .simplyAI, text: "Hey! Eduard, what do you need help with today?")
    ]
    @State private var inputText: String = ""

    var body: some View {
        VStack(spacing: 0) {
            Image("mascot-typing")
                .resizable()
                .scaledToFit()
                .frame(width: 140, height: 140)
                .shadow(color: Color("primary").opacity(0.3), radius: 5)
            
            ScrollViewReader { proxy in
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 12) {
                        ForEach(messages) { msg in
                            MessageBubble(message: msg)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 100) // space for input bar
                }
                .scrollIndicators(.hidden)
                .scrollDismissesKeyboard(.interactively)
                .onChange(of: messages.count) { _, _ in
                    if let last = messages.last?.id {
                        withAnimation { proxy.scrollTo(last, anchor: .bottom) }
                    }
                }
            }
        }
        .background(Color("background").ignoresSafeArea(.all))
        .safeAreaInset(edge: .bottom) {
            InputBar(text: $inputText) {
                sendMessage()
            }
            .padding(.top, 8)
        }
    }
    
    private func sendMessage() {
        let trimmed = inputText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        messages.append(.init(role: .user, text: trimmed))
        inputText = ""
        // Placeholder assistant reply for now
        messages.append(.init(role: .simplyAI, text: "🙂 I’m on it!"))
    }
}

private struct ChatMessage: Identifiable {
    enum Role { case user, simplyAI }
    let id = UUID()
    let role: Role
    let text: String
}

private struct MessageBubble: View {
    let message: ChatMessage

    var body: some View {
        HStack(alignment: .bottom, spacing: 8) {
            if message.role == .simplyAI {
                // Assistant avatar + bubble (left aligned)
                
                bubble
                Spacer()
            } else {
                // User bubble (right aligned)
                Spacer()
                bubble
            }
        }
    }
    
    private var bubble: some View {
        Text(message.text)
            .font(.system(size: 14, weight: .regular, design: .monospaced))
            .foregroundStyle(Color("text1"))
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(Color("background2"))
                    .stroke(message.role == .simplyAI ? Color.clear : Color("primary"))
                )
    }
}

private struct InputBar: View {
    @Binding var text: String
    var onSend: () -> Void

    var body: some View {
        HStack(alignment: .center, spacing: 8) {
            ZStack {
                // Text field + embedded send button
                HStack(spacing: 8) {
                    SKTextField(placeholder: "Message Simply…", text: $text)
                        .submitLabel(.send)
                        .onSubmit { onSend() }

                    Button(action: onSend) {
                        Image(systemName: "paperplane.fill")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(8)
                            .background(Circle().fill(Color("background")))
                            .foregroundStyle(Color("primary"))
                    }
                    .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                    .opacity(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? 0.5 : 1)
                }
                .padding(.horizontal, 10)
            }
            .frame(height: 44) // compact height
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            Color("background")
        )
    }
}

#Preview {
    SimplyView()
}
