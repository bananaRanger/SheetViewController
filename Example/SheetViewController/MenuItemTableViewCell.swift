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

class MenuItemTableViewCell: UITableViewCell {
  //MARK: properties
  @IBOutlet var imgIcon: UIImageView!
  @IBOutlet var iconViewContainer: UIView!
 
  @IBOutlet var lblTitle: UILabel!
  @IBOutlet var lblSubtitle: UILabel!
  
  //MARK: methods
  override func awakeFromNib() {
    super.awakeFromNib()
    iconViewContainer.layer.cornerRadius = iconViewContainer.bounds.height / 4
  }
  
  func setup(with item: MenuCell) {
    imgIcon.image = item.icon
    imgIcon.tintColor = item.iconColor
    iconViewContainer.backgroundColor = item.iconColor.withAlphaComponent(item.iconContainerAlpha)
    
    lblTitle.text = item.title
    lblSubtitle.text = item.subtitle
  }
}
