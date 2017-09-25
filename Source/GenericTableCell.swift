import UIKit

public final class GenericTableCell<CustomView>: UITableViewCell where CustomView: UIView, CustomView: ReusableGenericView {

    /// This is your custom view, which you can access external to customize your view.
    public let customView = CustomView()

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
}

private extension GenericTableCell {

    func setup() {
        self.contentView.addSubview(self.customView)

        self.setupConstraints()
    }

    func setupConstraints() {
        self.customView.translatesAutoresizingMaskIntoConstraints = false

        let constraints = [
            self.customView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            self.customView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            self.customView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            self.customView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
