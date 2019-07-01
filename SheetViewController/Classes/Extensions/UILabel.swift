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

//MARK: - UILabel extension
extension UILabel {
  private struct Configuration {
    static let textFontSize: CGFloat = 12
    static let actionFontSize: CGFloat = 16
    static let actionNumberOfLines: Int = 2
    static let textNumberOfLines: Int = 0
  }
  
  public enum TextType: Int {
    case title, message, action, cancelAction
    
    func isAction() -> Bool {
      return (self == .action || self == .cancelAction)
    }
    
    func isBold() -> Bool {
      return (self == .title || self == .cancelAction)
    }
  }
  
  public static func label(with text: String?, type: TextType) -> UILabel {
    let fontSize = type.isAction() ?
      Configuration.actionFontSize :
      Configuration.textFontSize
    
    let color = type.isAction() ?
      UIColor.action :
      UIColor.message
    
    let font = type.isBold() ?
      UIFont.boldSystemFont(ofSize: fontSize) :
      UIFont.systemFont(ofSize: fontSize)
    
    let lines = (type == .action) ?
      Configuration.actionNumberOfLines :
      Configuration.textNumberOfLines
    
    let label = UILabel(frame: .zero)
    label.font = font
    label.textAlignment = .center
    label.textColor = color
    label.numberOfLines = lines
    label.text = text
    
    return label
  }
}
