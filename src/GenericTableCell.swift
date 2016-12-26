import UIKit

public protocol ReusableGenericView {

    func prepareForReuse()
}

public final class GenericTableCell<CustomView>: UITableViewCell where CustomView: UIView, CustomView: ReusableGenericView {

    /// This is your custom view, which you can access externall to customize your view.
    public let customView = CustomView()

    /// You can optionally provide insets for your customView, if your design requires spacing.
    public var contentInsets = UIEdgeInsets() {
        didSet {
            self.customViewLeadingConstraint?.constant = self.contentInsets.left
            self.customViewTrailingConstraint?.constant = -self.contentInsets.right
            self.customViewTopConstraint?.constant = self.contentInsets.top
            self.customViewBottomConstraint?.constant = -self.contentInsets.bottom

            self.layoutIfNeeded()
        }
    }

    fileprivate var customViewLeadingConstraint: NSLayoutConstraint?
    fileprivate var customViewTrailingConstraint: NSLayoutConstraint?
    fileprivate var customViewTopConstraint: NSLayoutConstraint?
    fileprivate var customViewBottomConstraint: NSLayoutConstraint?

    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setup()
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Note: This acts as a passthrough, so a CustomView that implements the ReusableGenericView can have it acted upon.
    public override func prepareForReuse() {
        super.prepareForReuse()

        self.customView.prepareForReuse()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()

        let backgroundViewWidth = self.bounds.width - self.contentInsets.left - self.contentInsets.right
        let backgroundViewHeight = self.bounds.height - self.contentInsets.top - self.contentInsets.bottom
        self.selectedBackgroundView?.frame = CGRect(x: self.contentInsets.left, y: self.contentInsets.top, width: backgroundViewWidth, height: backgroundViewHeight)
    }
}

private extension GenericTableCell {

    func setup() {
        self.contentView.addSubview(self.customView)

        self.setupConstraints()
    }

    func setupConstraints() {
        self.customView.translatesAutoresizingMaskIntoConstraints = false

        self.customViewLeadingConstraint = self.customView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        self.customViewTrailingConstraint = self.customView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        self.customViewTopConstraint = self.customView.topAnchor.constraint(equalTo: self.topAnchor)
        self.customViewBottomConstraint = self.customView.bottomAnchor.constraint(equalTo: self.bottomAnchor)

        let constraints = [
            self.customViewLeadingConstraint,
            self.customViewTrailingConstraint,
            self.customViewTopConstraint,
            self.customViewBottomConstraint,
        ]

        NSLayoutConstraint.activate(constraints.flatMap { $0 })
    }
}


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
