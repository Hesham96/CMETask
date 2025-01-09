//
//  SessionDataTaskError.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

public enum SessionDataTaskError: Error {
    case failWithError(Error)
    case notValidURL
    case requestFailed
    case noData
    case notFound
    case notAuthorized
    case server
    case noInternetConnection
    case internalError(SessionDataTaskErrorResponse)
    case emptyErrorWithStatusCode(String)
}
