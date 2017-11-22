import UIKit

/// A `UIView` subclass must implement this protocol it intends to be used in a `ReusableView`.
public protocol ReusableGenericView {

    func prepareForReuse()
}

public extension ReusableGenericView {
    
    /// A default implementation for any class that declares itself a `ReusableGenericView`.
    func prepareForReuse() { }
    
}

/// A protocol that provides a default implementation for `reuseIdentifier`s.
public protocol ReusableView: class {}

public extension ReusableView where Self: UIView {
    
    /// A default implementation for reuseIdentifier by using the class's describing function.
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
    public func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }

        return cell
    }
    
    /// This method allows you to register a UITableViewCell with a UITableView by providing it's 
    /// class type instead of a reuseIdentifier.
    ///
    /// - Parameter _: The type of UITableViewCell to register
    public func register<T: UITableViewCell>(_: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

extension UICollectionReusableView: ReusableView {}

public extension UICollectionView {
    
    /// The types of supplementary views that may be registered
    public enum ElementKind : String {
        /// Rendered in the collection view as a section header
        case sectionHeader
        /// Rendered in the collection view as a section footer
        case sectionFooter
        
        public var rawValue: String {
            // For real though why isn't this a Swift enum yet
            switch self {
            case .sectionHeader: return UICollectionElementKindSectionHeader
            case .sectionFooter: return UICollectionElementKindSectionFooter
            }
        }
    }
    
    /// This method allows you to dequeue a UICollectionViewCell by providing it's class type instead
    /// of a reuseIdentifier. It capitalizes on a ReusableView's reuseIdentifier property,
    /// by using it in it's implementation.
    ///
    /// - Parameter indexPath: The indexPath to dequeue a UICollectionViewCell at.
    /// - Returns: a UICollectionViewCell to be dequeued.
    public func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }
    
    /// This method allows you to register a UICollectionViewCell with a UICollectionView by providing it's
    /// class type instead of a reuseIdentifier.
    ///
    /// - Parameter _: The type of UICollectionViewCell to register
    public func register<T: UICollectionViewCell>(_: T.Type) {
        self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
    }
    
    /// This method allows you to dequeue a UICollectionReusableView by providing it's class type instead
    /// of a reuseIdentifier. It capitalizes on a ReusableView's reuseIdentifier property,
    /// by using it in it's implementation.
    ///
    /// - Parameter kind: The kind of supplementary view (header or footer)
    /// - Parameter indexPath: The indexPath to dequeue a UICollectionViewCell at.
    /// - Returns: a UICollectionReusableView to be dequeued.
    public func dequeueReusableSupplementaryView<T: UICollectionReusableView>(ofKind kind: ElementKind, for indexPath: IndexPath) -> T {
        guard let view = dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue supplementary view with identifier: \(T.reuseIdentifier)")
        }
        return view
    }
    
    /// This method allows you to register a UICollectionReusableView with a UICollectionView by providing it's
    /// class type instead of a reuseIdentifier.
    ///
    /// - Parameter _: The type of UICollectionReusableView to register
    /// - Parameter kind: The kind of supplementary view (header or footer)
    public func register<T: UICollectionReusableView>(_: T.Type, forSupplementaryViewOfKind kind: ElementKind) {
        self.register(T.self, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: T.reuseIdentifier)
    }
}
