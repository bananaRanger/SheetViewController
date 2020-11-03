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

public class SheetContentView: UIView, ContentView {
  //MARK: properties
  private var stack: UIStackView?
  private var headerStack: UIStackView?
  private var contentStack: UIStackView?
  private var scrollView: UIScrollView?

  private var configuration: SheetContainerConfiguration
  
  public var headerViews: [UIView] {
    return headerStack?.arrangedSubviews ?? []
  }
  
  public var bodyViews: [UIView] {
    return contentStack?.arrangedSubviews ?? []
  }
  
  //MARK: inits
  override internal init(frame: CGRect) {
    self.configuration = ContainerConfiguration()
    super.init(frame: frame)
    setup()
  }
  
  internal required init?(coder aDecoder: NSCoder) {
    self.configuration = ContainerConfiguration()
    super.init(coder: aDecoder)
    setup()
  }
  
  public init(with frame: CGRect = .zero, configuration: SheetContainerConfiguration) {
    self.configuration = configuration
    super.init(frame: frame)
    setup()
  }
  
  //MARK: methods
  public func addHeaderView(_ view: UIView) {
    headerStack?.addArrangedSubview(view)
  }
  
  public func addBodyView(_ view: UIView) {
    if contentStack?.arrangedSubviews.isEmpty == false && configuration.isSeparatorLineShowed {
      let separator = SheetSeparatorView.create(with: configuration.separatorColor)
      contentStack?.addArrangedSubview(separator)
    }
    contentStack?.addArrangedSubview(view)
  }
}

//MARK: - Fileprivate extension of SheetContentView
fileprivate extension SheetContentView {
  func setup() {
    headerStack = UIStackView(frame: .zero)
    headerStack?.spacing = configuration.headerVerticalSpacing
    headerStack?.isLayoutMarginsRelativeArrangement = true
    headerStack?.axis = .vertical
    
    headerStack?.layoutMargins = UIEdgeInsets(
      top: configuration.innerHeaderSpacing.height,
      left: configuration.innerHeaderSpacing.width,
      bottom: configuration.innerHeaderSpacing.height,
      right: configuration.innerHeaderSpacing.width
    )
  
    let contentStack = UIStackView(frame: .zero)
    contentStack.axis = .vertical
    
    scrollView = UIScrollView(frame: .zero)
    scrollView?.delegate = self
    scrollView?.addSubview(contentStack)
    
    contentStack.translatesAutoresizingMaskIntoConstraints = false
    scrollView?.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView?.topAnchor.constraint(
      equalTo: contentStack.topAnchor
      ).isActive = true
    
    scrollView?.bottomAnchor.constraint(
      equalTo: contentStack.bottomAnchor
      ).isActive = true
    
    scrollView?.leadingAnchor.constraint(
      equalTo: contentStack.leadingAnchor
      ).isActive = true
    
    scrollView?.trailingAnchor.constraint(
      equalTo: contentStack.trailingAnchor
      ).isActive = true
    
    scrollView?.widthAnchor.constraint(
      equalTo: contentStack.widthAnchor
      ).isActive = true
    
    self.contentStack = contentStack

    let heightAnchor = scrollView?.heightAnchor.constraint(equalTo: contentStack.heightAnchor)
    heightAnchor?.priority = .defaultLow
    heightAnchor?.isActive = true
    
    let stack = UIStackView(frame: .zero)
    stack.axis = .vertical
    
    if let headerStack = headerStack {
      stack.addArrangedSubview(headerStack)
      if configuration.isSeparatorLineShowed {
        let separatorView = SheetSeparatorView.create(with: configuration.separatorColor)
        stack.addArrangedSubview(separatorView)
      }
    }
    
    if let scrollView = scrollView {
      stack.addArrangedSubview(scrollView)
    }
    
    addSubview(stack)
    stack.addAllSidesAnchors(to: self)
  }
}

//MARK: - UIScrollViewDelegate
extension SheetContentView: UIScrollViewDelegate {
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.x != .zero {
      scrollView.contentOffset.x = .zero
    }
  }
}

//MARK: - Fileprivate class SheetSeparatorView
fileprivate class SheetSeparatorView: UIView {
  static func create(with color: UIColor, height: CGFloat = 1) -> SheetSeparatorView {
    let height = height / UIScreen.main.scale
    let separator = SheetSeparatorView(frame: .zero)
    separator.backgroundColor = color
    separator.translatesAutoresizingMaskIntoConstraints = false
    separator.heightAnchor.constraint(equalToConstant: height).isActive = true
    return separator
  }
}
