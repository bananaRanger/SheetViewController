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

@IBDesignable
class CircularProgressView: UIView {
  //MARK: properties
  private var circleLayer = CAShapeLayer()
  private var progressLayer = CAShapeLayer()
  
  private let lineWidth = CGFloat(10)
  private var animationTimer: Timer?

  private var currentDuration = TimeInterval.zero
  private var currentValue = TimeInterval.zero
  private var interval = TimeInterval(0.1)
    
  @IBInspectable var ringBackgorundColor: UIColor = .groupTableViewBackground
  @IBInspectable var progresRingColor: UIColor = .black

  //MARK: methods
  override func layoutSubviews() {
    super.layoutSubviews()
    circularPath()
  }
  
  func circularPath() {
    let circularPath = UIBezierPath(
      arcCenter: CGPoint(x: frame.size.width / 2, y: frame.size.height / 2),
      radius: bounds.height / 2 - lineWidth / 2,
      startAngle: -.pi / 2,
      endAngle: 3 * .pi / 2,
      clockwise: true
    )
    
    circleLayer.path = circularPath.cgPath
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.lineCap = .round
    circleLayer.lineWidth = lineWidth
    circleLayer.strokeColor = ringBackgorundColor.cgColor
    
    progressLayer.path = circularPath.cgPath
    progressLayer.fillColor = UIColor.clear.cgColor
    progressLayer.lineCap = .round
    progressLayer.lineWidth = lineWidth
    progressLayer.strokeEnd = 0
    progressLayer.strokeColor = progresRingColor.cgColor
    
    if circleLayer.superlayer == nil &&
      progressLayer.superlayer == nil {
      layer.addSublayer(circleLayer)
      layer.addSublayer(progressLayer)
    }
  }
  
  func progressAnimation(duration: TimeInterval) {
    let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    circularProgressAnimation.duration = duration
    circularProgressAnimation.toValue = 1.0
    circularProgressAnimation.fillMode = .forwards
    circularProgressAnimation.isRemovedOnCompletion = false
    progressLayer.add(circularProgressAnimation, forKey: "circularProgressAnimation")
  }
}
