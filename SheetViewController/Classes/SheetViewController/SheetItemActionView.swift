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

//MARK: - typealiases
public typealias ActionViewClickHandler = ((SheetItemActionView) -> Void)

//MARK: - ItemActionView protocol
public protocol ItemActionView where Self: UIView {
  var imageView: UIImageView? { get }
  var textLabel: UILabel? { get }  
}

//MARK: - ItemActionView implementation
public class SheetItemActionView: ClickableView, ItemActionView {
  //MARK: private structs
  private struct Constraints {
    static let leftConstant: CGFloat = 24
    static let heightMultiplier: CGFloat = 0.44
    static let widthMultiplier: CGFloat = 1
    static let verticalConstant: CGFloat = 14
  }
  
  //MARK: properties
  private var _textLabel: UILabel?
  private var _textColor: UIColor?
  
  private var _imageView: UIImageView?
  private var _imageColor: UIColor?

  public var imageView: UIImageView? {
    return _imageView
  }
  
  public var textLabel: UILabel? {
    return _textLabel
  }
  
  //MARK: inits
  private override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }
  
  internal required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }
  
  //MARK: methods
  public class func make(with title: String?,
                         titleColor: UIColor? = .black,
                         image: UIImage?,
                         imageColor: UIColor? = .black,
                         clickHandler: ActionViewClickHandler?) -> SheetItemActionView {
    let view = SheetItemActionView(frame: .zero)
    view._textColor = titleColor
    view._imageColor = imageColor
    view.setup(with: title, image: image)
    view.clickHandler = { _ in clickHandler?(view) } 
    return view
  }
}

//MARK: - Fileprivate extension of SheetItemActionView
fileprivate extension SheetItemActionView {
  private func setup(with title: String? = nil, image: UIImage? = nil) {
    let label = UILabel.label(with: title, color: _textColor, type: .action)
    addSubview(label)
    
    let imageView = UIImageView(frame: .zero)
    imageView.tintColor = _imageColor
    imageView.image = image
    addSubview(imageView)
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    
    imageView.leftAnchor.constraint(
      equalTo: leftAnchor,
      constant: Constraints.leftConstant
      ).isActive = true
    
    imageView.heightAnchor.constraint(
      equalTo: heightAnchor,
      multiplier: Constraints.heightMultiplier
      ).isActive = true
    
    imageView.widthAnchor.constraint(
      equalTo: imageView.heightAnchor,
      multiplier: Constraints.widthMultiplier
      ).isActive = true
    
    imageView.topAnchor.constraint(
      greaterThanOrEqualTo: topAnchor,
      constant: Constraints.verticalConstant
      ).isActive = true
    
    imageView.bottomAnchor.constraint(
      greaterThanOrEqualTo: bottomAnchor,
      constant: -Constraints.verticalConstant
      ).isActive = true
    
    imageView.centerYAnchor.constraint(
      equalTo: centerYAnchor
      ).isActive = true
    
    label.translatesAutoresizingMaskIntoConstraints = false
    
    label.centerYAnchor.constraint(
      equalTo: centerYAnchor
      ).isActive = true
    
    label.centerXAnchor.constraint(
      equalTo: centerXAnchor
      ).isActive = true
    
    label.leftAnchor.constraint(
      greaterThanOrEqualTo: imageView.rightAnchor,
      constant: Constraints.leftConstant
      ).isActive = true
        
    _textLabel = label
    _imageView = imageView
  }
}
