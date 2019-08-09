import SwiftUI

struct PrimaryButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .buttonStyle(RoundedButtonStyle())
            .animation(.spring(response: 0.2, dampingFraction: 0.3, blendDuration: 0.5))
    }
}
