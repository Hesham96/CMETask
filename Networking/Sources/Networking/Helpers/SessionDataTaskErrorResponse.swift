//
//  SessionDataTaskErrorResponse.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

public struct SessionDataTaskErrorResponse: Codable, Sendable {
    let error: SessionDataTaskErrorModel?
}

public struct SessionDataTaskErrorModel: Codable, Sendable {
    let code: Int?
    let status: Int?
    let message: String?
}
