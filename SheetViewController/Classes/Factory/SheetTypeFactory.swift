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

//MARK: - ContainerViewFactory
class ContainerViewFactory {
  
  //MARK: - Properties
  var parent: UIView
  var headerTitle: String?
  var headerMessage: String?
  
  var isSeparately: Bool?
  
  //MARK: - Inits
  init(parent: UIView) {
    self.parent = parent
  }
  
  //MARK: - Methods
  static func configuration(with alignmentType: SheetAlignmentType,
                            and actionType: SheetActionType) -> ContainerConfiguration {
    switch actionType {
    case .separately:
      return SeparatelyContainerConfigurationBuilder.create(with: alignmentType)
    case .inner:
      return InnerContainerConfigurationBuilder.create(with: alignmentType)
    case .none:
      return NoneContainerConfigurationBuilder.create(with: alignmentType)
    }
  }
  
  func containerView(with alignmentType: SheetAlignmentType,
                     and actionType: SheetActionType) -> ContainerView {
    
    let configuration = ContainerViewFactory.configuration(
      with: alignmentType,
      and: actionType)

    switch actionType {
    case .separately:
      let container = ContainerViewSeparatelyActionBuilder(
        parent: parent,
        configuration: configuration
      )
      
      container.headerTitle = headerTitle
      container.headerMessage = headerMessage
      container.isSeparately = isSeparately
      container.alignmentType = alignmentType

      return container.create()
    case .inner:
      let container = ContainerViewInnerActionBuilder(
        parent: parent,
        configuration: configuration
      )
      
      container.headerTitle = headerTitle
      container.headerMessage = headerMessage
      container.isSeparately = isSeparately
      container.alignmentType = alignmentType

      return container.create()
    case .none:
      let container = ContainerViewNoneActionBuilder(
        parent: parent,
        configuration: configuration
      )
      
      container.headerTitle = headerTitle
      container.headerMessage = headerMessage
      container.isSeparately = isSeparately
      container.alignmentType = alignmentType
      
      return container.create()
    }
  }
  
}
