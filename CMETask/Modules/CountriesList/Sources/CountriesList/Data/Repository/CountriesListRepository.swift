//
//  CountriesListRepository.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation
import Combine
import Networking

final class CountriesListRepository {

    // MARK: - Properties

    private var cancellable: Set<AnyCancellable> = []
    private var client: CountriesListAPIClientProtocol

    // MARK: - Init

    init(client: CountriesListAPIClientProtocol) {
        self.client = client
    }

    // MARK: - Privates

    private func convert(_ response: [CountryNetworkResponse]?) -> CountriesRepositoryModel? {
        guard let countries = response else { return nil }
        return CountriesRepositoryModel(countries: countries.map { country in
            CountryRepositoryModel(
                name: country.name,
                capital: country.capital,
                region: country.region,
                flag: country.flag,
                countryCode: country.alpha2Code,
                currency: country.currency,
                population: "\(country.population ?? 0)"
            )
        })
    }
}

// MARK: - CountriesListRepositoryProtocol

extension CountriesListRepository: CountriesListRepositoryProtocol {
    func getCountries() -> AnyPublisher<CountriesRepositoryModel?, RepositoryError> {
        return Future { [weak self] promise in
            guard let self = self else { return }

            client.getCountries()
                .sink(receiveCompletion: { result in
                    print("Result -> ", result)
                }, receiveValue: { [weak self] response in
                    guard let self = self else { return }
                    let repositoryModel = self.convert(response)
                    promise(.success(repositoryModel))
                })
                .store(in: &self.cancellable)
        }
        .eraseToAnyPublisher()
    }
}
