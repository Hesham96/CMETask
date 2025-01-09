//
//  CountriesListUseCase.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation
import Combine
import Networking

final class CountriesListUseCase {

    // MARK: - Properties

    private var cancellable: Set<AnyCancellable> = []
    private var countriesListRepository: CountriesListRepositoryProtocol

    // MARK: - Init
    
    init(countriesListRepository: CountriesListRepositoryProtocol) {
        self.countriesListRepository = countriesListRepository
    }

    // MARK: - Privates

    private func convert(
        _ repositoryItem: [CountryRepositoryModel]?
    ) -> [CountryItem] {
        guard let countries = repositoryItem else { return [] }
        return countries.compactMap(
            { country in
                CountryItem(
                    name: country.name,
                    capital: country.capital,
                    region: country.region,
                    flagImageURL: country.flag,
                    countryCode: country.countryCode,
                    currency: country.currency,
                    population: country.population
                )
            })
    }

    private func convert(
        _ repositoryItem: CountriesRepositoryModel?
    ) -> CountriesListItems {
        CountriesListItems(countries: convert(repositoryItem?.countries))
    }
}

// MARK: - CountriesListUseCaseProtocol

extension CountriesListUseCase: CountriesListUseCaseProtocol {
    func fetchCountries() -> AnyPublisher<CountriesListItems, ModuleError> {
        return Future { [weak self] promise in
            guard let self else { return }
            countriesListRepository.getCountries()
                .sink(receiveCompletion: { result in
                    if case .failure(let error) = result {
                        promise(.failure(
                            ModuleError(error: error)
                        ))
                    }
                }, receiveValue: { [weak self] response in
                    guard let self else { return }
                    promise(.success(self.convert(response)))
                })
                .store(in: &cancellable)
        }
        .eraseToAnyPublisher()
    }
}
