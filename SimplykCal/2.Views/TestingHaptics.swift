import SwiftUI

struct HapticsDemoView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                SectionHeader("Impact")

                HapticTestButton("Alignment",  feedback: .alignment)
                HapticTestButton("decrease", feedback: .decrease)
                HapticTestButton("increase",  feedback: .increase)

                SectionHeader("Selection / Change")
                HapticTestButton("Selection", feedback: .selection)

                SectionHeader("Notification")
                HapticTestButton("Success", feedback: .success)
                HapticTestButton("Warning", feedback: .warning)
                HapticTestButton("Error",   feedback: .error)
            }
            .padding(20)
        }
        .navigationTitle("Haptics Test")
    }
}

private struct HapticTestButton: View {
    let title: String
    let feedback: SensoryFeedback
    @State private var trigger = 0

    init(_ title: String, feedback: SensoryFeedback) {
        self.title = title
        self.feedback = feedback
    }

    var body: some View {
        Button(action: { trigger &+= 1 }) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .frame(maxWidth: .infinity, minHeight: 48)
                .background(Color(.secondarySystemBackground))
                .foregroundStyle(Color.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .strokeBorder(Color.secondary.opacity(0.2), lineWidth: 1)
                )
        }
        .sensoryFeedback(feedback, trigger: trigger)
    }
}

private func SectionHeader(_ text: String) -> some View {
    Text(text.uppercased())
        .font(.system(size: 12, weight: .semibold, design: .rounded))
        .foregroundStyle(.secondary)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 8)
}

#Preview {
    NavigationStack { HapticsDemoView() }
}
