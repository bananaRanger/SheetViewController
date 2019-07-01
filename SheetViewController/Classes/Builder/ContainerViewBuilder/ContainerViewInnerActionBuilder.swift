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

//MARK: - InnerContainerConfiguration struct
struct InnerContainerConfiguration: ContainerConfiguration {
  var outerSpacing: CGSize = CGSize(width: 8, height: 24)

  var innerContentSpacing: CGSize = CGSize(width: 0, height: 8)
  var innerHeaderSpacing: CGSize = CGSize(width: 16, height: 16)
  var innerActionSpacing: CGSize = CGSize(width: 16, height: 16)
    
  var contentCornerRadius: CGFloat = 0
  var actionCornerRadius: CGFloat = 12
  
  var actionBackgroundColor: UIColor = .groupTableViewBackground
}

//MARK: - ContainerViewInnerActionBuilder class
class ContainerViewInnerActionBuilder: ContainerViewBuilder {
  
  //MARK: - Properties
  private let configuration: ContainerConfiguration
  
  var parent: UIView
  
  var headerTitle: String?
  var headerMessage: String?
  var actionTitle: String?
  var isSeparately: Bool?
  
  //MARK: - Inits
  internal required init(parent: UIView, configuration: ContainerConfiguration) {
    self.parent = parent
    self.configuration = configuration
  }
  
  //MARK: - Methods
  @discardableResult
  func create() -> ContainerView {
    let container = SheetContainerView(frame: .zero)
    parent.addSubview(container)
    container.backgroundColor = configuration.backgroundColor
    container.layer.cornerRadius = configuration.containerCornerRadius
    container.layer.masksToBounds = true
    container.translatesAutoresizingMaskIntoConstraints = false
    
    container.rightAnchor.constraint(
      equalTo: parent.rightAnchor,
      constant: -configuration.outerSpacing.width
      ).isActive = true
    
    container.bottomAnchor.constraint(
      equalTo: parent.bottomAnchor,
      constant: -configuration.outerSpacing.height
      ).isActive = true
    
    container.leftAnchor.constraint(
      equalTo: parent.leftAnchor,
      constant: configuration.outerSpacing.width
      ).isActive = true
    
    container.topAnchor.constraint(
      greaterThanOrEqualTo: parent.topAnchor,
      constant: configuration.outerSpacing.height * configuration.outerMultiplier
      ).isActive = true
    
    let actionViewBuilder = SheetActionViewBuilder(parent: container,
                                                   configuration: configuration)
    actionViewBuilder.actionTitle = actionTitle
    let action = actionViewBuilder.create()
    
    let contentViewBuilder = SheetContentViewBuilder(parent: container,
                                                     configuration: configuration)
    contentViewBuilder.headerTitle = headerTitle
    contentViewBuilder.headerMessage = headerMessage
    contentViewBuilder.action = action
    contentViewBuilder.isSeparately = isSeparately
    let content = contentViewBuilder.create()
    
    container.action = action
    container.content = content
    
    return container
  }
  
}
