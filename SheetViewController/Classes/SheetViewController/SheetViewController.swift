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

public class SheetViewController: UIViewController, SheetController {
  private var _actionType = SheetActionType.separately
  private let _animatedPresenting = AnimatedPresenting()
  private let _animatedDismissing = AnimatedDismissing()
  private var _containerViewCenter: CGPoint?
  
  private var headerTitle: String?
  private var headerMessage: String?
  private var actionTitle: String?
  
  public var containerView: ContainerView?
  
  public var sheetActionType: SheetActionType?
  public var verticalOffset: CGFloat?
  public var animatedPresenting: UIViewControllerAnimatedTransitioning? {
    return _animatedPresenting
  }
  public var animatedDismissing: UIViewControllerAnimatedTransitioning? {
    return _animatedDismissing
  }
  
  public static func alert(with title: String?,
                           message: String?,
                           actionType: SheetActionType = .separately,
                           isSeparately: Bool? = true) -> SheetController {
    let alert = SheetViewController()
    let factory = ContainerViewFactory(parent: alert.view)
    factory.headerTitle = title
    factory.headerMessage = message
    factory.isSeparately = isSeparately
    alert.containerView = factory.containerView(by: actionType)
    alert._actionType = actionType
    alert.modalPresentationStyle = .overCurrentContext
    alert.view.backgroundColor = .clear
    alert.transitioningDelegate = alert
    return alert
  }
  
  override public func present(_ viewControllerToPresent: UIViewController,
                               animated flag: Bool,
                               completion: (() -> Void)? = nil) { }
  
  public func addView(_ view: UIView) {
    containerView?.content?.addBodyView(view)
  }
  
  public func addRow(actionView: SheetItemActionView) {
    addView(actionView)
  }
  
  override public func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let gesture = UIPanGestureRecognizer(
      target: self,
      action: #selector(SheetViewController.wasDragged(gestureRecognizer:))
    )
    containerView?.addGestureRecognizer(gesture)
    containerView?.isUserInteractionEnabled = true
  }
  
  override public func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    resetContainerViewCenter()
  }
  
  public func setCancelButton(title: String?,
                              and handler: ActionButtonTouchUpInsideHandler?) {
    containerView?.action?.textLabel?.text = title
    containerView?.action?.handler = { [weak self] in
      self?.dismiss(animated: true, completion: nil)
      handler?()
    }
  }
  
  override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard touches.first?.view == view else { return }
    dismiss(animated: true, completion: nil)
  }
}

//MARK: - Fileprivate extension of SheetViewController
fileprivate extension SheetViewController {
  func resetContainerViewCenter() {
    _containerViewCenter = view?.convert(containerView?.center ?? .zero, to: view)
  }
}

//MARK: - UIViewControllerTransitioningDelegate extension
fileprivate extension SheetViewController {
  private struct AnimationConfiguration {
    static let moving: TimeInterval = 0.1
    static let ending: TimeInterval = 0.5
  }
  
  @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
    guard let view = gestureRecognizer.view,
      let center = _containerViewCenter else { return }
    
    if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
      let translation = gestureRecognizer.translation(in: containerView)
      
      guard view.center.y + translation.y >= center.y else { return }
      
      guard view.frame.origin.y < center.y else {
        dismiss(animated: true, completion: nil)
        return
      }
      
      UIView.animate(withDuration: AnimationConfiguration.moving, animations: {
        view.center = CGPoint(x: view.center.x, y: view.center.y + translation.y)
      })
    } else if gestureRecognizer.state == .ended {
      UIView.dampingAnimate(
        duration: AnimationConfiguration.ending,
        animations: {
          view.center = self._containerViewCenter ?? .zero
      }, completion: nil)
    }
    gestureRecognizer.setTranslation(.zero, in: containerView)
  }
}

//MARK: - Working with orientation
extension SheetViewController {
  override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    let hSizeClass = traitCollection.horizontalSizeClass
    let vSizeClass = traitCollection.verticalSizeClass
    let isPortrait = hSizeClass == .compact && vSizeClass == .regular
    
    let configuration = ContainerViewFactory.configuration(by: _actionType)
    
    view.constraints.forEach { constraint in
      if constraint.firstAttribute == .top {
        constraint.constant = isPortrait ?
          (configuration.outerSpacing.height * configuration.outerMultiplier) :
          configuration.outerSpacing.height
      } else if constraint.firstAttribute == .left {
        constraint.constant = isPortrait ?
          configuration.outerSpacing.width :
          (configuration.outerSpacing.width + (view.frame.width / 5))
      } else if constraint.firstAttribute == .right {
        constraint.constant = isPortrait ?
          -configuration.outerSpacing.width :
          (-configuration.outerSpacing.width - (view.frame.width / 5))
      }
    }
    
    updateViewConstraints()
  }
  
  override public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { [weak self] context in
      self?.resetContainerViewCenter()
    }
  }
}

//MARK: - UIViewControllerTransitioningDelegate extension
extension SheetViewController: UIViewControllerTransitioningDelegate {
  public func animationController(forPresented presented: UIViewController,
                           presenting: UIViewController,
                           source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return _animatedPresenting
  }
  
  public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return _animatedDismissing
  }
}
