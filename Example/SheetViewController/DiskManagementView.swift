//
//  DiskManagementView.swift
//  SheetViewController_Example
//
//  Created by Anton Yereshchenko on 7/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class DiskManagementView: UIView {
  @IBOutlet weak var contentView: UIView!
  @IBOutlet weak var actionView: UIView!
  @IBOutlet weak var imgIcon: UIView!
  @IBOutlet weak var btnDiskManagement: UIButton!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    contentView.layer.cornerRadius = 16
    contentView.layer.shadowOpacity = 0.06
    contentView.layer.shadowRadius = 16
    contentView.layer.shadowOffset = CGSize(width: 0, height: 8)
    
    actionView.layer.cornerRadius = 16
    actionView.layer.shadowOpacity = 0.06
    actionView.layer.shadowRadius = 16
    actionView.layer.shadowOffset = CGSize(width: 0, height: 8)
    
    btnDiskManagement.tintColor = .action
  }
}
