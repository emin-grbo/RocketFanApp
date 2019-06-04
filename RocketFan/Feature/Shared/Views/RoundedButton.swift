import UIKit

final class RoundedButton: UIButton {
    /// When the bounds change, update the button radius
    override var bounds: CGRect {
        didSet { radius = bounds.height / 2.0 }
    }

    /// Shrink the view slightly while user is touching
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.05) {
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: 0.95, y: 0.95) : .identity
            }
        }
    }

    private var radius: CGFloat = 0.0 {
        didSet {
            guard oldValue != radius else { return }

            layer.cornerRadius = radius
            contentEdgeInsets = UIEdgeInsets(top: 8, left: radius, bottom: 8, right: radius)

            layoutIfNeeded()
        }
    }
}
