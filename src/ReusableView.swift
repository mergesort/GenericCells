import UIKit

/// A `UIView` subclass must implement this protocol it intends to be used in a `ReusableView`
public protocol ReusableGenericView {

    func prepareForReuse()
}

/// A protocol that provides a default implementation for `reuseIdentifier`s.
public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    /// A default implementation for reuseIdentifier by using the class's describing function
    public static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell: ReusableView {}

public extension UITableView {
    
    /// This method allows you to dequeue a UITableViewCell by providing it's class type instead 
    /// of a reuseIdentifier. It capitalizes on a ReusableView's reuseIdentifier property, 
    /// by using it in it's implementation.
    ///
    /// - Parameter indexPath: The indexPath to dequeue a UITableViewCell at.
    /// - Returns: a UITableViewCell to be dequeued.
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
    
    /// This method allows you to register a UITableViewCell with a UITableView by providing it's 
    /// class type instead of a reuseIdentifier.
    ///
    /// - Parameter _: The type of UITableViewCell to register
    public func register<T: UITableViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UICollectionViewCell: ReusableView {}

public extension UICollectionView {
    
    /// This method allows you to dequeue a UICollectionViewCell by providing it's class type instead
    /// of a reuseIdentifier. It capitalizes on a ReusableView's reuseIdentifier property,
    /// by using it in it's implementation.
    ///
    /// - Parameter indexPath: The indexPath to dequeue a UICollectionViewCell at.
    /// - Returns: a UICollectionViewCell to be dequeued.
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// This method allows you to register a UICollectionViewCell with a UICollectionView by providing it's
    /// class type instead of a reuseIdentifier.
    ///
    /// - Parameter _: The type of UICollectionViewCell to register
    public func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
}
