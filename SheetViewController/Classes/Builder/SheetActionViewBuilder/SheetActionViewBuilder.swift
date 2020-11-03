// MIT License
//
// Copyright (c) 2019 Anton Yereshchenko
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

import UIKit

class SheetActionViewBuilder: ViewBuilder {
  //MARK: properties
  private let configuration: SheetContainerConfiguration
  
  var actionTitle: String?
  
  var parent: UIView
  
  //MARK: inits
  internal required init(parent: UIView, configuration: SheetContainerConfiguration) {
    self.parent = parent
    self.configuration = configuration
  }
  
  //MARK: methods
  @discardableResult
  func create() -> ActionView {
    let action = SheetActionView(title: actionTitle, color: configuration.actionTextColor)
    parent.addSubview(action)
    action.textLabel?.font = configuration.actionTextFont
    action.backgroundColor = configuration.actionBackgroundColor
    action.layer.cornerRadius = configuration.actionCornerRadius
    
    action.translatesAutoresizingMaskIntoConstraints = false
    
    action.heightAnchor.constraint(
      equalToConstant: configuration.actionHeight
      ).isActive = true
    
    action.rightAnchor.constraint(
      equalTo: parent.rightAnchor,
      constant: -configuration.innerActionSpacing.width
      ).isActive = true
    
    action.bottomAnchor.constraint(
      equalTo: parent.bottomAnchor,
      constant: -configuration.innerActionSpacing.height
      ).isActive = true
    
    action.leftAnchor.constraint(
      equalTo: parent.leftAnchor,
      constant: configuration.innerActionSpacing.width
      ).isActive = true
    return action
  }
}
