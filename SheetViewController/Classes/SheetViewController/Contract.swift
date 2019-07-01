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

public typealias ActionButtonTouchUpInsideHandler = (() -> Void)

//MARK: - SheetActionType enum
public enum SheetActionType: Int {
  case separately
  case inner
  case none
}

//MARK: - ContentView protocol
public protocol ContentView: UIView {
  var headerViews: [UIView] { get }
  var bodyViews: [UIView] { get }
  
  var isSeparately: Bool? { get }
  var separatorColor: UIColor { get set }

  func addHeaderView(_ view: UIView)
  func addBodyView(_ view: UIView)
}

//MARK: - ActionView protocol
public protocol ActionView: UIView {
  var textLabel: UILabel? { get }
  var handler: ActionButtonTouchUpInsideHandler? { get set }
}

//MARK: - ContainerView protocol
public protocol ContainerView: UIView {
  var content: ContentView? { get set }
  var action: ActionView? { get set }
}

//MARK: - SheetController protocol
public protocol SheetController: UIViewController {
  var containerView: ContainerView? { get set }
  var sheetActionType: SheetActionType? { get }
  var verticalOffset: CGFloat? { get }
  var animatedPresenting: UIViewControllerAnimatedTransitioning? { get }
  var animatedDismissing: UIViewControllerAnimatedTransitioning? { get }
  
  static func alert(with title: String?,
                    message: String?,
                    actionType: SheetActionType,
                    isSeparately: Bool?) -> SheetController
  
  func addView(_ view: UIView)
  func addRow(actionView: SheetItemActionView)

  func setCancelButton(title: String?,
                       and handler: ActionButtonTouchUpInsideHandler?)
}
