//
//  ModuleError.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//

import Combine

public enum ModuleError: Error {
  case noInternetConnection
  case notFound
  case notAuthorized
  case server
  case noData
  case unowned

  public init(error: RepositoryError) {
    switch error {
      case .noInternetConnection:
        self = .noInternetConnection
      case .server:
        self = .server
      case .notFound:
        self = .notFound
      case .notAuthorized:
        self = .notAuthorized
      default:
        self = .unowned
    }
  }
}
