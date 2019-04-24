import UIKit

/// A container viewcontroller that manages state between child view controllers
class ContentStateViewController: UIViewController {
    private var state: State?
    private var shownViewController: UIViewController?

    func transition(to newState: State) {
        shownViewController?.remove()
        let controller = viewController(for: newState)
        add(controller)
        shownViewController = controller
        state = newState
    }
}

private extension ContentStateViewController {
    func viewController(for state: State) -> UIViewController {
        switch state {
        case .loading:
            return UIViewController()
        case .failed( _):
            fatalError("ErrorViewController needs to be implemented")
        case .render(let viewController):
            return viewController
        }
    }
}

extension ContentStateViewController {
    enum State {
        case loading
        case failed(Error)
        case render(UIViewController)
    }
}
