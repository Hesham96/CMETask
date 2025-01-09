//
//  CountriesListAPIRequest.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Networking

enum CountriesListAPIRequest: APIRequestConfiguration {
    case getCountries

    var method: HTTPMethod {
        switch self {
        case .getCountries:
            return .GET
        }
    }

    var path: String {
        switch self {
        case .getCountries:
            return "\(Endpoints.baseURL)" + "\(Endpoints.allCountries)"
        }
    }

    var parameters: Parameters? {
        nil
    }

    var headers: HTTPHeaders? {
        nil
    }

    var queryParams: [String : Any]? {
        nil
    }
}
