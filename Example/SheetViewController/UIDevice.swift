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

import UIKit.UIDevice

extension UIDevice {
  //MARK: properties
  var totalDiskSpaceInGB: String {
    return bytesInGB(totalDiskSpaceInBytes)
  }
  
  var freeDiskSpaceInGB: String {
    return bytesInGB(freeDiskSpaceInBytes)
  }
  
  var usedDiskSpaceInGB: String {
    return bytesInGB(usedDiskSpaceInBytes)
  }
  
  var totalDiskSpaceInMB: String {
    return bytesInMB(totalDiskSpaceInBytes)
  }
  
  var freeDiskSpaceInMB: String {
    return bytesInMB(freeDiskSpaceInBytes)
  }
  
  var usedDiskSpaceInMB: String {
    return bytesInMB(usedDiskSpaceInBytes)
  }
  
  var totalDiskSpaceInBytes: Int64 {
    guard let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
      let space = (systemAttributes[FileAttributeKey.systemSize] as? NSNumber)?.int64Value else { return 0 }
    return space
  }
  
  var freeDiskSpaceInBytes: Int64 {
    if #available(iOS 11.0, *) {
      if let space = try? URL(fileURLWithPath: NSHomeDirectory() as String).resourceValues(forKeys: [URLResourceKey.volumeAvailableCapacityForImportantUsageKey]).volumeAvailableCapacityForImportantUsage {
        return space
      } else {
        return 0
      }
    } else {
      if let systemAttributes = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory() as String),
        let freeSpace = (systemAttributes[FileAttributeKey.systemFreeSize] as? NSNumber)?.int64Value {
        return freeSpace
      } else {
        return 0
      }
    }
  }
  
  var usedDiskSpaceInBytes: Int64 {
    return totalDiskSpaceInBytes - freeDiskSpaceInBytes
  }
  
  //MARK: methods
  func bytesInMB(_ bytes: Int64) -> String {
    return formatter(bytes)
  }
  
  func bytesInGB(_ bytes: Int64) -> String {
    return ByteCountFormatter.string(
      fromByteCount: bytes,
      countStyle: ByteCountFormatter.CountStyle.decimal
    )
  }

  private func formatter(_ bytes: Int64) -> String {
    let formatter = ByteCountFormatter()
    formatter.allowedUnits = ByteCountFormatter.Units.useMB
    formatter.countStyle = ByteCountFormatter.CountStyle.decimal
    formatter.includesUnit = false
    return formatter.string(fromByteCount: bytes) as String
  }
}
