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

//MARK: - ContainerConfiguration struct
public protocol ContainerConfiguration {
  var outerSpacing: CGSize { get }
  var outerMultiplier: CGFloat { get }

  var innerContentSpacing: CGSize { get }
  var innerHeaderSpacing: CGSize { get }
  var innerActionSpacing: CGSize { get }

  var actionHeight: CGFloat { get }
  
  var containerCornerRadius: CGFloat { get }
  var contentCornerRadius: CGFloat { get }
  var actionCornerRadius: CGFloat { get }

  var backgroundColor: UIColor { get }
  var actionBackgroundColor: UIColor { get }
}

extension ContainerConfiguration {
  var outerMultiplier: CGFloat {
    return 4
  }

  var actionHeight: CGFloat {
    return 54
  }
  
  var containerCornerRadius: CGFloat {
    return 14
  }
  
  var backgroundColor: UIColor {
    return .white
  }
  
  var actionBackgroundColor: UIColor {
    return .white
  }
}

//MARK: - EmptyContainerConfiguration struct
struct EmptyContainerConfiguration: ContainerConfiguration {
  var outerSpacing: CGSize = .zero

  var innerContentSpacing: CGSize = .zero
  var innerHeaderSpacing: CGSize = .zero
  var innerActionSpacing: CGSize = .zero

  var actionHeight: CGFloat = 0
  
  var containerCornerRadius: CGFloat = 0
  var contentCornerRadius: CGFloat = 0
  var actionCornerRadius: CGFloat = 0
}
