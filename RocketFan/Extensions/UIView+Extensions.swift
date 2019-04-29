import UIKit

extension UIView {
    func embedSubview(_ subview: UIView) {
        guard subview.superview != self else { return }

        if subview.superview != nil {
            subview.removeFromSuperview()
        }

        subview.translatesAutoresizingMaskIntoConstraints = false
        subview.frame = bounds

        addSubview(subview)

        NSLayoutConstraint.activate([
            subview.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: subview.trailingAnchor),

            subview.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: subview.bottomAnchor)
            ])
    }

    func isContainedWithin(_ other: UIView) -> Bool {
        var current: UIView? = self
        while let proposedView = current {
            if proposedView == other { return true }
            current = proposedView.superview
        }

        return false
    }
}
