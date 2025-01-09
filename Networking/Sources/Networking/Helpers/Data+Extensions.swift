//
//  Data+Extensions.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
