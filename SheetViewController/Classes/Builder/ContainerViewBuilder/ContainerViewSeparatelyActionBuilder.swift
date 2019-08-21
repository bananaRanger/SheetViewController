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

//MARK: - Container Configuration Builder

//MARK: - SeparatelyCenterContainerConfiguration struct
struct SeparatelyCenterContainerConfiguration: ContainerConfiguration {
  var outerSpacing: CGSize = CGSize(width: 18, height: 24)
  
  var innerContentSpacing: CGSize = CGSize(width: 0, height: 8)
  var innerHeaderSpacing: CGSize = CGSize(width: 16, height: 16)
  var innerActionSpacing: CGSize = CGSize(width: 0, height: 8)
    
  var contentCornerRadius: CGFloat = 12
  var actionCornerRadius: CGFloat = 12
}

//MARK: - SeparatelyBottomContainerConfiguration struct
struct SeparatelyBottomContainerConfiguration: ContainerConfiguration {
  var outerSpacing: CGSize = CGSize(width: 8, height: 24)
  
  var innerContentSpacing: CGSize = CGSize(width: 0, height: 8)
  var innerHeaderSpacing: CGSize = CGSize(width: 16, height: 16)
  var innerActionSpacing: CGSize = CGSize(width: 0, height: 8)
  
  var contentCornerRadius: CGFloat = 12
  var actionCornerRadius: CGFloat = 12
}

//MARK: - SeparatelyContainerConfigurationBuilder
class SeparatelyContainerConfigurationBuilder: ContainerConfigurationBuilder {
  static func create(with type: SheetAlignmentType) -> ContainerConfiguration {
    switch type {
    case .center: return SeparatelyCenterContainerConfiguration()
    case .bottom: return SeparatelyBottomContainerConfiguration()
    }
  }
}

//MARK: - View Configuration Builder 

//MARK: - ContainerViewSeparatelyActionBuilder class
class ContainerViewSeparatelyActionBuilder: ContainerViewBuilder {
  
  //MARK: - Properties
  private let configuration: ContainerConfiguration
  
  var parent: UIView
  
  var headerTitle: String?
  var headerMessage: String?
  var actionTitle: String?
  var isSeparately: Bool?
  
  var alignmentType: SheetAlignmentType = .bottom
  
  //MARK: - Inits
  internal required init(parent: UIView, configuration: ContainerConfiguration) {
    self.parent = parent
    self.configuration = configuration
  }
  
  //MARK: - Methods
  @discardableResult
  func create() -> ContainerView {
    switch alignmentType {
    case .center:
      let builder = ContainerCenterViewSeparatelyActionBuilder(
        parent: parent,
        configuration: configuration)
      builder.headerTitle = headerTitle
      builder.headerMessage = headerMessage
      builder.actionTitle = actionTitle
      builder.isSeparately = isSeparately
      return builder.create()
    case .bottom:
      let builder = ContainerBottomViewSeparatelyActionBuilder(
        parent: parent,
        configuration: configuration)
      builder.headerTitle = headerTitle
      builder.headerMessage = headerMessage
      builder.actionTitle = actionTitle
      builder.isSeparately = isSeparately
      return builder.create()
    }
  }
}

//MARK: - ContainerCenterViewSeparatelyActionBuilder class
class ContainerCenterViewSeparatelyActionBuilder: ContainerViewBuilder {
  
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
    container.layer.cornerRadius = configuration.containerCornerRadius
    container.layer.masksToBounds = true
    container.translatesAutoresizingMaskIntoConstraints = false

    container.rightAnchor.constraint(
      equalTo: parent.rightAnchor,
      constant: -configuration.outerSpacing.width
      ).isActive = true
    
    container.leftAnchor.constraint(
      equalTo: parent.leftAnchor,
      constant: configuration.outerSpacing.width
      ).isActive = true
    
    container.topAnchor.constraint(
      greaterThanOrEqualTo: parent.topAnchor,
      constant: configuration.outerSpacing.height * configuration.outerMultiplier
      ).isActive = true
    
    container.centerXAnchor.constraint(
      equalTo: parent.centerXAnchor
      ).isActive = true
    
    container.centerYAnchor.constraint(
      equalTo: parent.centerYAnchor
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

//MARK: - ContainerBottomViewSeparatelyActionBuilder class
class ContainerBottomViewSeparatelyActionBuilder: ContainerViewBuilder {
  
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
