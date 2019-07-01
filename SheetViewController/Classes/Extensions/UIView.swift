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

import UIKit.UIView

//MARK: - UIView extension
extension UIView {  
  public func addAllSidesAnchors(to parent: UIView) {
    translatesAutoresizingMaskIntoConstraints = false
    rightAnchor.constraint(equalTo: parent.rightAnchor).isActive = true
    bottomAnchor.constraint(equalTo: parent.bottomAnchor).isActive = true
    leftAnchor.constraint(equalTo: parent.leftAnchor).isActive = true
    topAnchor.constraint(equalTo: parent.topAnchor).isActive = true
  }
}

//MARK: - UIView extension (animations)
extension UIView {
  private struct AnimationConfiguration {
    static let delay: TimeInterval = 0.0
    static let damping: CGFloat = 0.74
    static let velocity: CGFloat = 0.74
  }
  
  public static func dampingAnimate(duration: TimeInterval,
                             animations: @escaping (() -> (Void)),
                             completion: ((Bool) -> (Void))?) {
    UIView.animate(
      withDuration: duration,
      delay: AnimationConfiguration.delay,
      usingSpringWithDamping: AnimationConfiguration.damping,
      initialSpringVelocity: AnimationConfiguration.velocity,
      options: [],
      animations: animations, completion: completion)
  }
}
