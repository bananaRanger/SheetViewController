# SheetViewController

[![CI Status](https://img.shields.io/travis/antonyereshchenko@gmail.com/SheetViewController.svg?style=flat)](https://travis-ci.org/antonyereshchenko@gmail.com/SheetViewController)
[![Version](https://img.shields.io/cocoapods/v/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)
[![License](https://img.shields.io/cocoapods/l/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)
[![Platform](https://img.shields.io/cocoapods/p/SheetViewController.svg?style=flat)](https://cocoapods.org/pods/SheetViewController)

SheetViewController is a fully customizable and native-like alert sheet controller UI component written in Swift.

<p align="center">
  <img width="72%" height="72%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/00-preview.png?raw=true">
</p>


## Features

- [x] Three types of alerts: with inner action, with outer action, without action.
- [x] Two alignment types of alerts: bottom, center.
- [x] Fully customisation components. You can customise content (header, actions), color, fonts, forms, spaces and etc.
- [x] Works on iPad.
- [x] Easy to use.
- [x] Works on both orientations: portrait, landscape.

### Demo

Interaction with ```SheetViewController``` that have ```.inner``` action type:

<p align="center">
  <img width="216" height="417" src="https://github.com/bananaRanger/SheetViewController/blob/master/Resources/demo.gif?raw=true">
</p>

## UI customization Q&A

### How to change the color?

<p align="center">
  <img width="58%" height="58%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/01-how%20to%20change%20the%20color.png?raw=true">
</p>

### How to change the corner radius?

<p align="center">
  <img width="58%" height="58%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/02-how%20to%20change%20the%20corner%20radius.png?raw=true">
</p>

### How to change the spacing?

<p align="center">
  <img width="58%" height="58%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/03-how%20to%20change%20the%20spacing.png?raw=true">
</p>

### How to change sheet offsets?

<p align="center">
  <img width="58%" height="58%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/04-how%20to%20change%20sheet%20offsets.png?raw=true">
</p>

### Other settings

<p align="center">
  <img width="58%" height="58%" src="https://github.com/bananaRanger/SheetViewController/blob/2.0.0/Resources/05-other%20settings.png?raw=true">
</p>

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

SheetViewController is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
inhibit_all_warnings!

target 'YOUR_TARGET_NAME' do
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
//
// 'alignmentType' values:
// - .bottom 
// - .center
//
// 'alignmentType' values:
// - .separately 
// - .inner
// - .none

let sheet = Self.init(
      with: titleMessage,
      message: message,
      alignmentType: .bottom,
      actionType: .separately) { configuration in
      	// UI customization (see UI customization Q&A section)
        return configuration
    }

alert.setCancelButton(title: cancelTitle, and: cancelHandler)

alert.addView(customRowView)
alert.addRow(actionView: row)

present(alert, animated: true, completion: nil)
```

## Author

[📧](mailto:anton.yereshchenko@gmail.com?subject=[GitHub]%20Source%20SheetViewController) Anton Yereshchenko

## License

SheetViewController is available under the MIT license. See the LICENSE file for more info.

## Inspired by

Designing for iPhone in Figma - https://setproduct.com/ios

## Used in project

Icons:

Icons8 - https://icons8.com
