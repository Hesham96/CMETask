//
//  CountriesListUseCaseProtocol.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation
import Combine
import Networking

public protocol CountriesListUseCaseProtocol {
    func fetchCountries() -> AnyPublisher<CountriesListItems, ModuleError>
}

public struct CountriesListItems {
    let countries: [CountryItem]

    public init(countries: [CountryItem]) {
        self.countries = countries
    }
}

public struct CountryItem: Identifiable, Equatable {
    public let id: UUID = UUID()
    var name: String?
    var capital: String?
    var region: String?
    var flagImageURL: String?
    var countryCode: String?
    var currency: String?
    var population: String?
}
