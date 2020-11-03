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

extension Array where Element == Manager {
  static var mockItems: [Element] {
    [
      Manager(
        name: "Luke Parr",
        phone: "+1 202 555 0128",
        photo: UIImage(named: "ManagerIcon1")
      ),
      Manager(
        name: "Sonia Bailey",
        phone: "+1 202 555 0128",
        photo: UIImage(named: "ManagerIcon2")
      ),
      Manager(
        name: "Joshua Dowd",
        phone: "+1 202 555 0162",
        photo: UIImage(named: "ManagerIcon3")
      ),
      Manager(
        name: "Joseph Carr",
        phone: "+1 202 555 0123",
        photo: UIImage(named: "ManagerIcon4")
      ),
      Manager(
        name: "Christian Young",
        phone: "+1 202 555 0128",
        photo: UIImage(named: "ManagerIcon5")
      )
    ]
  }
}
