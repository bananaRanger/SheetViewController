//
//  StorageInfo.swift
//  SheetViewController_Example
//
//  Created by Anton Yereshchenko on 7/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class StorageInfo: UIView {

  @IBOutlet weak var lblAvailable: UILabel!
  @IBOutlet weak var lblGBAvailable: UILabel!

  @IBOutlet weak var lblTotal: UILabel!
  @IBOutlet weak var lblGBTotal: UILabel!

  @IBOutlet weak var progressView: UIProgressView!

  override func awakeFromNib() {
    progressView.progressTintColor = .action
    progressView.trackTintColor = .groupTableViewBackground
  }
  
  static func instanceFromNib() -> StorageInfo? {
    return Bundle.main.loadNibNamed(String(describing:self), owner: self, options: nil)?.first as? StorageInfo
  }

}
