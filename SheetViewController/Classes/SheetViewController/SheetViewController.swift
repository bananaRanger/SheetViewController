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

open class SheetViewController: UIViewController, SheetController {
  //MARK: properties
  private var _title: String?
  private var _message: String?
  private var _alignmentType = SheetAlignmentType.bottom
  private var _actionType = SheetActionType.separately
  private let _animatedPresenting = AnimatedPresenting()
  private let _animatedDismissing = AnimatedDismissing()
  private var _containerViewCenter: CGPoint?
  private var configuration: SheetContainerConfiguration = ContainerConfiguration.default
  
  public typealias DidClose = (() -> Void)
  
  public var didClose: DidClose?
  
  public var containerView: ContainerView?
  
  public var alignmentType: SheetAlignmentType? { return _alignmentType }
  public var actionType: SheetActionType? { return _actionType }
  
  public var animatedPresenting: UIViewControllerAnimatedTransitioning? {
    return _animatedPresenting
  }
  
  public var animatedDismissing: UIViewControllerAnimatedTransitioning? {
    return _animatedDismissing
  }
  
  //MARK: inits
  private init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required public init?(coder: NSCoder) {
    super.init(coder: coder)
  }
  
  required public init(with title: String?,
                       message: String?,
                       alignmentType: SheetAlignmentType,
                       actionType: SheetActionType,
                       modifier: ContainerConfigurationModifier? = nil) {
    super.init(nibName: nil, bundle: nil)

    self.modalPresentationStyle = .overCurrentContext
    self.transitioningDelegate = self
    
    self._title = title
    self._message = message
    self._alignmentType = alignmentType
    self._actionType = actionType
    
    var configuration = ConfigurationFactory.configuration(
      with: alignmentType,
      and: actionType
    )
    
    if let modifier = modifier {
      self.configuration = modifier(&configuration)
    } else {
      self.configuration = configuration
    }
    
    self._animatedPresenting.transitionBackgroundColor = configuration.transitionBackgroundColor
  }
  
  //MARK: methods
  open override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .clear
    
    let containerFactory = ContainerViewFactory(
      parent: self.view,
      configuration: configuration,
      headerTitle: _title,
      headerMessage: _message
    )
    
    self.containerView = containerFactory.containerView(
      with: _alignmentType,
      and: _actionType
    )
  }
  
  override open func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    let gesture = UIPanGestureRecognizer(
      target: self,
      action: #selector(SheetViewController.wasDragged(gestureRecognizer:))
    )
    containerView?.addGestureRecognizer(gesture)
    containerView?.isUserInteractionEnabled = true
  }
  
  override open func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    resetContainerViewCenter()
  }
  
  override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    guard touches.first?.view == view else { return }
    closeSheet()
  }
  
  open func addView(_ view: UIView) {
    containerView?.content?.addBodyView(view)
  }
  
  open func addRow(actionView: SheetItemActionView) {
    addView(actionView)
  }
  
  open func setCancelButton(title: String?,
                              and handler: ActionButtonTouchUpInsideHandler?) {
    containerView?.action?.textLabel?.text = title
    containerView?.action?.handler = { [weak self] in
      self?.closeSheet()
      handler?()
    }
  }
}

//MARK: - Fileprivate extension of SheetViewController
fileprivate extension SheetViewController {
  func closeSheet() {
    dismiss(animated: true) { [weak self] in
      self?.didClose?()
    }
  }
  
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
        closeSheet()
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
    super.traitCollectionDidChange(previousTraitCollection)
    
    let hSizeClass = traitCollection.horizontalSizeClass
    let vSizeClass = traitCollection.verticalSizeClass
    let isPortrait = hSizeClass == .compact && vSizeClass == .regular
    
    view.constraints.forEach { constraint in
      if constraint.firstAttribute == .top {
        constraint.constant = isPortrait ?
          configuration.outerSpacing.height * configuration.portraitTopOuterMultiplier :
          configuration.outerSpacing.height
      } else if constraint.firstAttribute == .left {
        constraint.constant = isPortrait ?
          configuration.outerSpacing.width :
          (configuration.outerSpacing.width +
            (view.frame.width / configuration.landscapeHorizontalOuterDivider))
      } else if constraint.firstAttribute == .right {
        constraint.constant = isPortrait ?
          -configuration.outerSpacing.width :
          (-configuration.outerSpacing.width -
            (view.frame.width / configuration.landscapeHorizontalOuterDivider))
      }
    }
    updateViewConstraints()
  }
  
  override public func viewWillTransition(
    to size: CGSize,
    with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: nil) { [weak self] context in
      self?.resetContainerViewCenter()
    }
  }
}

//MARK: - UIViewControllerTransitioningDelegate extension
extension SheetViewController: UIViewControllerTransitioningDelegate {
  public func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return _animatedPresenting
  }
  
  public func animationController(
    forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return _animatedDismissing
  }
}
