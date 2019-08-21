# SheetViewController

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/SheetViewController.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/SheetViewController)
[![Version](https://img.shields.io/cocoapods/v/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)
[![License](https://img.shields.io/cocoapods/l/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)
[![Platform](https://img.shields.io/cocoapods/p/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)

<p align="center">
  <img width="64%" height="64%" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/logo.png?raw=true">
</p>

## About

Customizable native-like sheet alert controller with three action types: separately, inner, none.

### Demo

Interaction with ```SheetViewController``` that have ```.inner``` action type:

<p align="center">
  <img width="216" height="417" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/demo.mov?raw=true">
</p>

### Separately action type

```swift
let alert = SheetViewController.alert(with: <title>, message: <message>, actionType: .separately)
```

#### Portrait

<p align="center">
	<img width="187" height="406" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/separately_portrait.png?raw=true">
</p>

#### Landscape

<p align="center">
	<img width="406" height="187" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/separately_landscape.png?raw=true">
</p>

### Inner action type

```swift
let alert = SheetViewController.alert(with: <title>, message: <message>, actionType: .inner)
```

#### Portrait

<p align="center">
	<img width="187" height="406" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/inner_portrait.png?raw=true">
</p>

#### Landscape

<p align="center">
	<img width="406" height="187" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/inner_landscape.png?raw=true">
</p>

### None action type

```swift
let alert = SheetViewController.alert(with: <title>, message: <message>, actionType: .none)
```

#### Portrait

<p align="center">
	<img width="187" height="406" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/none_portrait.png?raw=true">
</p>

#### Landscape

<p align="center">
	<img width="406" height="187" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/none_landscape.png?raw=true">
</p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SheetViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR-TARGET-NAME' do
  use_frameworks!
	pod 'SheetViewController'
end
```

## Usage

```swift
// 'titleMessage' - title for alert.
// 'message' - message for alert.
// 'cancelTitle' - title for bottom button.
// 'cancelHandler' - the handler of bottom button click.
//
// 'customRowView' - the object of class 'UIView' or his inheritors.
// 'row' - the object of class 'SheetItemActionView'.

let alert = SheetViewController.alert(with: titleMessage, message: message, actionType: .inner)
alert.setCancelButton(title: cancelTitle, and: cancelHandler)

alert.addView(customRowView)
alert.addRow(actionView: row)

present(alert, animated: true, completion: nil)
```

## Author

Anton Yereshchenko

## License

SheetViewController is available under the MIT license. See the LICENSE file for more info.

## Inspired by

Designing for iPhone in Figma - https://setproduct.com/ios

## Used in project

Icons:

Icons8 - https://icons8.com
