# GenericTableCell

#### Creating UITableViewCell subclasses is so Swift 2.

---

Introducing, _*GenericTableCell*_. Capitalizing on Swift's generics, we can get all the benefits of a custom UITableViewCell class, without the hassle of a new class for each of them.

---

#### Let's show you how ot use it.

Create a UIView subclass for the layout you want:

```swift
final class MyView: UIView {

    let imageView: UIImageView
    let titleLabel: UILabel
    let subtitleLabel: UILabel
    // And add more views to your heart's content

}
```

Register the cell with a UITableView:

```swift
tableView.register(GenericTableCell<MyView>.self)

```

Dequeue the cell with a UITableView:

```swift
let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as GenericTableCell<MyView>
```

And customize it to your heart's content. The view you wish to access will be available via the `.customView` property:

```swift
cell.customView.titleLabel.text = "This library rules!"
cell.customView.imageView.image = UIImage(named: "success")
```

Extra credit, let's recycling support. Extend your view with the `ReusableGenericView` protocol:

```swift
extension MyView: ReusableGenericView {

    func prepareForReuse() {
        self.titleLabel.text = ""
        self.subtitleLabel.text = ""
        self.imageView.image = nil
    }

}
```

And it will get called when the cell is recycled.

## Installation
You can use [CocoaPods](http://cocoapods.org/) to install `GenericTableCell` by adding it to your `Podfile`:

```swift
platform :ios, '9.0'
use_frameworks!

pod 'GenericTableCell'
```

Or install it manually by downloading `GenericTableCell.swift` and dropping it in your project.

## About me

Hi, I'm [Joe](http://fabisevi.ch) everywhere on the web, but especially on [Twitter](https://twitter.com/mergesort).

## License

See the [license](LICENSE) for more information about how you can use GenericTableCell.

## Is that it?

Yes, that's it. And if you don't like it, well sorry, here's a rainbow. 🌈
