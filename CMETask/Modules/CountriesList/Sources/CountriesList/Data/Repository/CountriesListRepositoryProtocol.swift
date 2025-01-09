//
//  CountriesListRepositoryProtocol.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//


import Combine
import Networking

protocol CountriesListRepositoryProtocol: CountriesListRepositoryGettable {}

protocol CountriesListRepositoryGettable {
  func getCountries() -> AnyPublisher<CountriesRepositoryModel?, RepositoryError>
}
