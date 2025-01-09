//
//  APIRequestConfiguration.swift
//  Networking
//
//  Created by Hesham Aly on 07/01/2025.
//



import Foundation

public
protocol APIRequestConfiguration {
  var method: HTTPMethod { get }
  var path: String { get }
  var queryParams: [String: Any]? { get }
  var parameters: Parameters? { get }
  var headers: HTTPHeaders? { get }
}

extension APIRequestConfiguration {
  private var baseHeaders: HTTPHeaders {
    let headers = [
      "Content-Type": "application/json",
      "Accept": "application/json",
    ]
    return headers
  }

  public func asURLRequest() -> URLRequest {
    /// URL Components
    var components = components
    components.path = "/" + path

    /// Request
    var urlRequest = URLRequest(url: components.url!)
    if path.contains("https://") || path.contains("http://"),
       let url = URL(string: path) {
      urlRequest = URLRequest(url: url)
    }
    urlRequest.httpMethod = method.rawValue

    /// Headers
    let requestHeaders = baseHeaders + headers
    requestHeaders.forEach {
      urlRequest.addValue($1, forHTTPHeaderField: $0)
    }

    /// Parameters you need to pass with the request
    if let parameters = parameters {
      do {
        urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
      } catch let error {
        print(error)
      }
    }
    return urlRequest
  }


  private func addQueryItems(queryParams: [String: Any]) -> [URLQueryItem] {
    return queryParams.map({
      URLQueryItem(name: $0.key, value: "\($0.value)")}
    )
  }

  var components: URLComponents {
    let components = URLComponents()
    return components
  }
}

public typealias HTTPHeaders = [String:String]
public typealias Parameters = [String: Any]
