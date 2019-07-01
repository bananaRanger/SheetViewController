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

public class ClickableView: UIView {
  
  //MARK: - Properties
  private var _isShadow: Bool = false
  
  public typealias ClickHandler = ((UIView) -> Void)
  public var clickHandler: ClickHandler?
  
  public var isShadow: Bool {
    get {
      return _isShadow
    } set {
      _isShadow = newValue
      if isShadow {
        layer.shadow(isClick: false)
      } else {
        layer.removeShadow()
      }
    }
  }
  
  //MARK: - Private structs
  private struct AnimationDuration {
    static let touchDown: TimeInterval = 0.16
    static let touchUp: TimeInterval = 0.32
  }
  
  private struct Styling {
    static let alphaComponent: (active: CGFloat, inactive: CGFloat) = (1.0, 0.32)
  }
  
  //MARK: - Overrided methods
  override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    UIView.animate(withDuration: AnimationDuration.touchDown) { [weak self] in
      self?.subviews.forEach { $0.alpha = Styling.alphaComponent.inactive }
      guard self?._isShadow == true else { return }
      self?.layer.shadow(isClick: true)
    }
  }
  
  override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesCancelled(touches, with: event)
    UIView.animate(withDuration: AnimationDuration.touchUp) { [weak self] in
      self?.subviews.forEach { $0.alpha = Styling.alphaComponent.active }
      guard self?._isShadow == true else { return }
      self?.layer.shadow(isClick: false)

    }
  }
  
  override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    UIView.animate(withDuration: AnimationDuration.touchUp, animations: { [weak self] in
      self?.subviews.forEach { $0.alpha = Styling.alphaComponent.active }
      guard self?._isShadow == true else { return }
      self?.layer.shadow(isClick: false)
    })
    clickHandler?(self)
  }
  
}

//MARK: - Fileprivate extension of CALayer
fileprivate extension CALayer {
  private struct Configuration {
    static let shadowOpacity: (active: CGFloat, inactive: CGFloat) = (0.32, 0.1)
    static let shadowOffset: (active: CGSize, inactive: CGSize) = (CGSize(width: 0, height: 10),
                                                                   CGSize(width: 0, height: 5))
    static let shadowRadius: CGFloat = 8

    static let animationDuration: TimeInterval = 0.16
    static let touchUp: TimeInterval = 0.32
  }
  
  func shadow(isClick: Bool) {
    let animation = CABasicAnimation(keyPath: "shadowOpacity")
    animation.fromValue = isClick ? Configuration.shadowOpacity.active : Configuration.shadowOpacity.inactive
    animation.toValue = isClick ? Configuration.shadowOpacity.inactive : Configuration.shadowOpacity.active
    animation.duration = Configuration.animationDuration
    add(animation, forKey: nil)
    
    shadowColor = UIColor.lightGray.cgColor
    shadowOpacity = Float(isClick ? Configuration.shadowOpacity.inactive : Configuration.shadowOpacity.active)
    shadowOffset = isClick ? Configuration.shadowOffset.inactive : Configuration.shadowOffset.active
    shadowRadius = Configuration.shadowRadius
  }
  
  func removeShadow() {
    shadowColor = nil
    shadowOpacity = 0
    shadowOffset = .zero
    shadowRadius = 0
  }
}
