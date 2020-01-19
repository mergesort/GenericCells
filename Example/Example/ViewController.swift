import UIKit

private struct RowContent {
    let title: String
    let subtitle: String
    let buttonTitle: String
    let buttonColor: UIColor
}

class ViewController: UIViewController {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 76.0
        tableView.register(GenericTableCell<CustomView>.self)
        tableView.tableFooterView = UIView()

        return tableView
    }()
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setup()
    }

    private let rowContents: [RowContent] = [
        RowContent(title: "Famous Dogs", subtitle: "Bo Obama, Spuds McKenzie, The Taco Bell Dog, and more!", buttonTitle: "Don't like dogs?", buttonColor: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)),
        RowContent(title: "Famous Cats", subtitle: "Grumpy Cat, Maru, Lil Bub, Nala, Tigger, and more!", buttonTitle: "Don't like cats?", buttonColor: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)),
        RowContent(title: "Famous Foxes", subtitle: "Fantastic Mr. Fox, Fox in Sox, That fox from the video \"What Does The Fox Say\", and more!", buttonTitle: "Don't like foxes?", buttonColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)),
        RowContent(title: "Famous Groundhogs", subtitle: "Punxsutawney Phil, State Island Chuck, Sir Walter Walley, and more!", buttonTitle: "Don't like groundhogs?", buttonColor: #colorLiteral(red: 0.7254902124, green: 0.4784313738, blue: 0.09803921729, alpha: 1)),
        RowContent(title: "Famous Lions", subtitle: "Mufasa, Mayor Lionheart, Scar, and more!", buttonTitle: "Don't like lions?", buttonColor: #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)),
    ]

}

extension ViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let currentRowContent = self.rowContents[indexPath.row]

        let alertController = UIAlertController(title: "You want some \(currentRowContent.title)", message: "Let's see 'em!", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Maybe later", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rowContents.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableCell<CustomView>

        // You can configure this however and wherever you want, but we're doing it here for simplicity.
        let currentRowContent = self.rowContents[indexPath.row]
        cell.customView.titleLabel.text = currentRowContent.title
        cell.customView.subtitleLabel.text = currentRowContent.subtitle
        cell.customView.actionButton.setTitle(currentRowContent.buttonTitle, for: .normal)
        cell.customView.actionButton.setTitleColor(UIColor.white, for: .normal)
        cell.customView.actionButton.backgroundColor = currentRowContent.buttonColor
        cell.customView.actionButton.addTarget(self, action: #selector(showAngryWarning), for: .touchUpInside)

        return cell
    }

}

private extension ViewController {

    func setup() {
        self.title = "Famous Animals"

        self.view.addSubview(self.tableView)
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.setupConstraints()
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.topLayoutGuide.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomLayoutGuide.bottomAnchor).isActive = true
    }

    @objc func showAngryWarning() {
        let alertController = UIAlertController(title: "And why not?", message: "Some people are just downright animals…", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Goodbye", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

}

