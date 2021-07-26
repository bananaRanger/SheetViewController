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

public protocol SheetContainerConfiguration {
  var outerSpacing: CGSize { get set }
  
  var portraitTopOuterMultiplier: CGFloat { get set }
  var landscapeHorizontalOuterDivider: CGFloat { get set }

  var headerVerticalSpacing: CGFloat { get set }
  
  var innerContentSpacing: CGSize { get set }
  var innerHeaderSpacing: CGSize { get set }
  var innerActionSpacing: CGSize { get set }
  
  var actionHeight: CGFloat { get set }
  
  var containerCornerRadius: CGFloat { get set }
  var contentCornerRadius: CGFloat { get set }
  var actionCornerRadius: CGFloat { get set }
  
  var backgroundColor: UIColor { get set }
  var headerTextColor: UIColor { get set }
  var actionBackgroundColor: UIColor { get set }
  var actionTextColor: UIColor { get set }
  var actionTextFont: UIFont { get set }
  var transitionBackgroundColor: UIColor { get set }
  
  var isSeparatorLineShowed: Bool { get set }
  var separatorColor: UIColor { get set }
}
