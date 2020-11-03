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

class AnimatedPresenting: NSObject {
  private struct AnimationConfiguration {
    static let damping: CGFloat = 0.74
    static let velocity: CGFloat = 0.74
  }
  
  //MARK: properties
  let duration: TimeInterval = 0.64
  let delay: TimeInterval = .zero
  var transitionBackgroundColor: UIColor?
}

//MARK: - UIViewControllerAnimatedTransitioning
extension AnimatedPresenting: UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView
    
    guard let from = transitionContext.viewController(forKey: .from),
      let to = transitionContext.viewController(forKey: .to) as? SheetViewController,
      let fromView = from.view,
      let toView = to.view,
      let alertView = to.containerView
      else { return }
    
    containerView.addSubview(toView)
    toView.addAllSidesAnchors(to: containerView)
    containerView.bringSubviewToFront(fromView)
    
    UIView.animate(
      withDuration: duration / 2,
      delay: delay,
      options: .curveEaseIn,
      animations: { [weak self] in
        toView.backgroundColor = self?.transitionBackgroundColor
    })
    
    let initialAlertFrame = alertView.bounds

    alertView.frame.origin.x = .zero
    alertView.frame.origin.y = fromView.bounds.height

    UIView.dampingAnimate(
      duration: duration,
      animations: {
        alertView.frame = initialAlertFrame
    }, completion: { _ in
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
    })
  }
}
