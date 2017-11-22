import UIKit

public final class GenericCollectionReusableView<CustomView>: UICollectionReusableView where CustomView: UIView, CustomView: ReusableGenericView {
    
    /// This is your custom view, which you can access external to customize your view.
    public let customView = CustomView()
    
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
}

private extension GenericCollectionReusableView {
    
    func setup() {
        self.addSubview(self.customView)
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = .zero
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.customView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            self.customView.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.customView.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
            self.customView.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            self.customView.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

