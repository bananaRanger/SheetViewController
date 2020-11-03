// MIT License
//
// Copyright (c) 2020 Anton Yereshchenko
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

enum MenuCell: Int, CaseIterable {
  case loader
  case managers
  case storageInfo
  
  var identifier: String { return "menuItem" }
  
  var iconContainerAlpha: CGFloat { return 0.16 }
  
  var iconColor: UIColor {
    switch self {
    case .loader:       return UIColor(red: 235/255, green: 73/255, blue: 95/255, alpha: 1)
    case .managers:     return UIColor(red: 118/255, green: 213/255, blue: 113/255, alpha: 1)
    case .storageInfo:  return UIColor(red: 38/255, green: 127/255, blue: 246/255, alpha: 1)
    }
  }
  
  var icon: UIImage? {
    switch self {
    case .loader:       return UIImage(named: "MenuLoaderIcon")
    case .managers:     return UIImage(named: "MenuManagersIcon")
    case .storageInfo:  return UIImage(named: "MenuStorageInfoIcon")
    }
  }
  
  var title: String {
    switch self {
    case .loader:       return "Loader"
    case .managers:     return "Managers"
    case .storageInfo:  return "Storage Info"
    }
  }
  
  var subtitle: String {
    switch self {
    case .loader:       return "Sheet with 'none' action type and 'center' alignment type"
    case .managers:     return "Sheet with 'inner' action type and 'center' alignment type"
    case .storageInfo:  return "Sheet with 'separately' action type and 'center' alignment type"
    }
  }
}
