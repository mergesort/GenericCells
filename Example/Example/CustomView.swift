import UIKit

// We're setting up a custom `UIView` instead of using a custom `UITableViewCell` subclass.
final class CustomView: UIView {
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        return label
    }()

    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8.0
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical

        return stackView
    }()
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension CustomView {
    
    func setup() {
        self.addSubview(self.stackView)

        self.stackView.addArrangedSubview(self.titleLabel)
        self.stackView.addArrangedSubview(self.subtitleLabel)
        self.stackView.addArrangedSubview(self.actionButton)

        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}

// This extension can live anywhere in the same target. I tend to have all my `ReusableGenericView`s
// in a separate folder to not couple it directly to the view, but it's up to you!
//
// You can even leave the implementation empty, there is a default implementation.
extension CustomView: ReusableGenericView {

    func prepareForReuse() {
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
        self.actionButton.setTitle(nil, for: .normal)
    }
    
}
