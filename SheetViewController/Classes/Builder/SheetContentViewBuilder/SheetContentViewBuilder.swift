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

//MARK: - SheetContentViewBuilder class
class SheetContentViewBuilder: ViewBuilder {
  
  //MARK: - Properties
  private let configuration: ContainerConfiguration
  
  var action: ActionView?
  
  var headerTitle: String?
  var headerMessage: String?
  
  var parent: UIView
  
  var isSeparately: Bool?
  
  //MARK: - Inits
  internal required init(parent: UIView, configuration: ContainerConfiguration) {
    self.parent = parent
    self.configuration = configuration
  }
  
  //MARK: - Methods
  @discardableResult
  func create() -> ContentView {
    let content = SheetContentView(with: .zero, configuration: configuration, isSeparately: isSeparately)
    parent.addSubview(content)
    content.backgroundColor = configuration.backgroundColor
    content.layer.cornerRadius = configuration.contentCornerRadius
    content.layer.masksToBounds = true
    content.translatesAutoresizingMaskIntoConstraints = false
    
    content.heightAnchor.constraint(
      greaterThanOrEqualToConstant: 1
      ).isActive = true
    
    content.rightAnchor.constraint(
      equalTo: parent.rightAnchor,
      constant: -configuration.innerContentSpacing.width
      ).isActive = true
    
    content.leftAnchor.constraint(
      equalTo: parent.leftAnchor,
      constant: configuration.innerContentSpacing.width
      ).isActive = true
    
    content.topAnchor.constraint(
      equalTo: parent.topAnchor
      ).isActive = true
    
    content.bottomAnchor.constraint(
      equalTo: action?.topAnchor ?? parent.bottomAnchor,
      constant: -configuration.innerContentSpacing.height
      ).isActive = true
    
    if let headerTitle = headerTitle {
      content.addHeaderView(UILabel.label(with: headerTitle, type: .title))
    }
    
    if let headerMessage = headerMessage {
      content.addHeaderView(UILabel.label(with: headerMessage, type: .message))
    }
    return content
  }
}
