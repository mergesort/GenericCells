# Change Log

# 1.2 (2017-09-25)

- Adding support for Swift 4.

#### ⚠️ Breaking changes ⚠️

- `GenericTableCell` and `GenericCollectionCell` now are bound to the the cell's `self.contentView.layoutMarginsGuide` instead of `self.contentView` anchors. 

- This replaces the old functionality where you would set a `contentInsets` property. 

If you wish to set custom insets, instead of writing:

```swift
cell.contentInsets = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
```

Now write:

```swift
cell.layoutMargins = UIEdgeInsets(top: 10.0, left: 20.0, bottom: 10.0, right: 20.0)
```

--- 
#### ⚠️ Breaking changes ⚠️

- For functions that had a parameter `activate: Bool`, it has now been renamed `isActive: Bool`.

# 1.1.1 (2016-12-03)

- There is now a default implementation for `prepareForReuse`, in case you don't have anything that needs reusing in your cell.

# 1.1 (2016-10-04)

- GenericTableCell is now GenericCells.

- This means that all the fun stuff you could do with a UITableView, you can now do with a UICollectionView. 🎊 🦁 🎊


# 1.0 (2016-10-04)

- Initial release 🎉