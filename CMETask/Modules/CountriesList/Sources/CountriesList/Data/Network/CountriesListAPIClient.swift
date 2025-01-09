//
//  CountriesListAPIClient.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Networking
import Combine

protocol CountriesListAPIClientProtocol {
    func getCountries() -> AnyPublisher<[CountryNetworkResponse], SessionDataTaskError>
}

class CountriesListAPIClient {

    private var client: BaseAPIClientProtocol

    init(client: BaseAPIClientProtocol) {
        self.client = client
    }
}

// MARK: - CountriesListAPIClientProtocol

extension CountriesListAPIClient: CountriesListAPIClientProtocol {
    func getCountries() -> AnyPublisher<[CountryNetworkResponse], SessionDataTaskError> {
        let request = CountriesListAPIRequest.getCountries
        return client.perform(request.asURLRequest())
    }
}
