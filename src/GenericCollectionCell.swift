import UIKit

public final class GenericCollectionCell<CustomView>: UICollectionViewCell where CustomView: UIView, CustomView: ReusableGenericView {
    
    /// This is your custom view, which you can access external to customize your view.
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
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
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

private extension GenericCollectionCell {
    
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
