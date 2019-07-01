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

//MARK: - SheetActionView class
public class SheetActionView: ClickableView, ActionView {
  
  //MARK: - Properties
  public var textLabel: UILabel?
  public var handler: ActionButtonTouchUpInsideHandler?

  //MARK: - Inits
  override public init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  internal required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  public init(frame: CGRect = .zero, title: String?) {
    super.init(frame: frame)
    setup(with: title)
  }
}

//MARK: - Fileprivate extension of SheetActionView
fileprivate extension SheetActionView {
  private func setup(with title: String? = nil) {
    clickHandler = { [weak self] view in self?.handler?() }
    
    let label = UILabel.label(with: title, type: .cancelAction)
    addSubview(label)
    label.addAllSidesAnchors(to: self)
    self.textLabel = label
  }
}
