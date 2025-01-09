//
//  Dictionary+Extensions.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

extension Dictionary {
  static func + (lhs: Dictionary, rhs: Dictionary?) -> Dictionary {
    if rhs == nil {
      return lhs
    } else {
      var dic = lhs
      rhs!.forEach { dic[$0] = $1 }
      return dic
    }
  }
}
