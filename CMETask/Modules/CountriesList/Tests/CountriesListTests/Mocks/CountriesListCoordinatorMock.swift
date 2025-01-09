//
//  CountriesListCoordinatorMock.swift
//  CountriesList
//
//  Created by Hesham Aly on 09/01/2025.
//

import Foundation
import Common

final class CountriesListCoordinatorMock: CountriesListCoordinatorProtocol {
    var shownCountryName: String?

    func start() {}

    func goBack() {}

    func showCountryDetails(
        name: String?,
        capital: String?,
        population: String?,
        region: String?,
        currency: String?,
        flagImageURL: String?
    ) {
        shownCountryName = name
    }
}
