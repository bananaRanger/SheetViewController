// MIT License
//
// Copyright (c) 2020 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import SheetViewController

class StorageInfoSheetViewController: SheetViewController {
  //MARK: properties
  private static let titleMessage = "Storage info"
  private static let message = "Select action to manipulate your disk\n (Don't panic! Actions just close The Sheet)"
  
  private let ejectTitle = "Eject"
  private let defragmentationTitle = "Defragmentation"
  private let cleanTitle = "Clean"
  
  private let cancelAction = "Done"
  
  private var color: UIColor?

  private var clickHandler: ActionViewClickHandler {
    return { [weak self] actionView in
      self?.dismiss(animated: true, completion: nil)
    }
  }
  
  //MARK: methods
  static func `default`(with color: UIColor) -> Self {
    let sheet = Self.init(
      with: titleMessage,
      message: message,
      alignmentType: .bottom,
      actionType: .separately) { configuration in
        configuration.actionBackgroundColor = color
        return configuration
    }
    sheet.color = color
    return sheet
  }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
}

//MARK: - StorageInfoSheetViewController extension (setup)
extension StorageInfoSheetViewController {
  func setup() {
    guard let storageInfo = StorageInfo.instanceFromNib() else { return }
    let device = UIDevice.current
    let percents = Float(device.usedDiskSpaceInBytes) / Float(device.totalDiskSpaceInBytes)
    
    storageInfo.lblUsed.text = device.usedDiskSpaceInGB
    storageInfo.lblTotal.text = device.totalDiskSpaceInGB
    storageInfo.progressView.progress = percents
    storageInfo.progressView.progressTintColor = color
    
    addView(storageInfo)
    
    let eject = SheetItemActionView.make(
      with: ejectTitle,
      titleColor: color,
      image: UIImage(named: ejectTitle),
      imageColor: color,
      clickHandler: clickHandler)
    addRow(actionView: eject)
    
    let defragmentation = SheetItemActionView.make(
      with: defragmentationTitle,
      titleColor: color,
      image: UIImage(named: defragmentationTitle),
      imageColor: color,
      clickHandler: clickHandler)
    addRow(actionView: defragmentation)
    
    let clean = SheetItemActionView.make(
      with: cleanTitle,
      titleColor: color,
      image: UIImage(named: cleanTitle),
      imageColor: color,
      clickHandler: clickHandler)
    addRow(actionView: clean)
    
    setCancelButton(title: cancelAction, and: nil)
  }
}
