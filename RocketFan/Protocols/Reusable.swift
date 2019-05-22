import Foundation
import UIKit

/// A collection of protocols which make registering and dequeueing cells much cleaner

protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension UITableViewCell: Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

protocol NibLoadable: class {
    static var nib: UINib { get }
}

extension NibLoadable {
    static var nib: UINib {
        let name = String(describing: self)
        let bundle = Bundle(for: self)
        return UINib(nibName: name, bundle: bundle)
    }
}

extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) where T: NibLoadable {
        print(T.nib, T.reuseIdentifier)
        register(T.nib, forCellReuseIdentifier: T.reuseIdentifier)
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type = T.self) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier \(T.reuseIdentifier)")
        }

        return cell
    }
}
