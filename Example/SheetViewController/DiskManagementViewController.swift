//
//  DiskManagementViewController.swift
//  SheetViewController
//
//  Created by antonyereshchenko@gmail.com on 07/01/2019.
//  Copyright (c) 2019 antonyereshchenko@gmail.com. All rights reserved.
//

import UIKit
import SheetViewController

class DiskManagementViewController: UIViewController {

  private let titleMessage = "IPhone's disk info"
  private let message = "Select action to manipulate your disk"
  
  private let ejectTitle = "Eject"
  private let defragmentationTitle = "Defragmentation"
  private let cleanTitle = "Clean"

  private let cancelAction = "Done"
  
  var tView: DiskManagementView! {
    guard isViewLoaded else { return nil }
    return (view as! DiskManagementView)
  }
  
  private var customAlert: SheetController {
    let alert = SheetViewController.alert(
      with: titleMessage,
      message: message,
      alignmentType: .bottom,
      actionType: .inner)
    
    alert.containerView?.action?.backgroundColor = .action
    alert.containerView?.action?.textLabel?.textColor = .white
    
    alert.setCancelButton(title: cancelAction, and: nil)
    
    if let view = StorageInfo.instanceFromNib() {
      alert.addView(view)
    }
    
    let eject = SheetItemActionView.make(
      with: ejectTitle,
      image: UIImage(named: ejectTitle),
      clickHandler: clickHandler)
    alert.addRow(actionView: eject)
        
    let defragmentation = SheetItemActionView.make(
      with: defragmentationTitle,
      image: UIImage(named: defragmentationTitle),
      clickHandler: clickHandler)
    alert.addRow(actionView: defragmentation)
    
    let clean = SheetItemActionView.make(
      with: cleanTitle,
      image: UIImage(named: cleanTitle),
      clickHandler: clickHandler)
    alert.addRow(actionView: clean)

    return alert
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    alert()
  }
  
  @IBAction func btnDiskManagementTouchUpInside(_ sender: UIButton) {
    alert()
  }
  
  private func alert() {
    present(customAlert, animated: true, completion: nil)
  }
  
  private var clickHandler: ActionViewClickHandler {
    return { [weak self] actionView in
      print("'\(actionView.textLabel?.text ?? "-")' did click")
      self?.dismiss(animated: true, completion: nil)
    }
  }

}
