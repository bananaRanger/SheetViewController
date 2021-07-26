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

class ManagerCollectionViewCell: UICollectionViewCell {
  //MARK: properties
  @IBOutlet weak var imgView: UIImageView!
  
  static var identifier: String = "managerItem"
  
  var borderColor = UIColor(red: 118/255, green: 213/255, blue: 113/255, alpha: 1)
  
  override var isSelected: Bool {
      didSet {
        let animation = CABasicAnimation(keyPath: "borderColor")
        animation.fromValue = isSelected ?  UIColor.clear.cgColor : borderColor.cgColor
        animation.toValue = isSelected ? borderColor.cgColor : UIColor.clear.cgColor
        animation.duration = 0.16
        layer.add(animation, forKey: "borderColor")
        layer.borderColor = isSelected ? borderColor.cgColor : UIColor.clear.cgColor
        layer.borderWidth = 2
      }
  }
  
  //MARK: methods
  override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = bounds.height / 2
    layer.masksToBounds = true
  }
}

//MARK: ManagerCollectionViewCell extension (setup)
extension ManagerCollectionViewCell {
  func setup(with manager: Manager?) {
    imgView.image = manager?.photo
  }
}
