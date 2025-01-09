//
//  CountryDetailsModuleFactory.swift
//  CountryDetails
//
//  Created by Hesham Aly on 08/01/2025.
//

import Foundation
import Common

public class CountryDetailsModuleFactory {

    @MainActor
    public static func makeModule(
        with coordinator: CountriesListCoordinatorProtocol,
        name: String?,
        capital: String?,
        population: String?,
        region: String?,
        currency: String?,
        flagImageURL: String?
    ) -> CountryDetailsView {
        let viewModel = CountryDetailsViewModel(coordinator: coordinator)
        let view = CountryDetailsView(
            viewModel: viewModel,
            name: name,
            capital: capital,
            population: population,
            region: region,
            currency: currency,
            flagImageURL: flagImageURL
        )
        return view
    }
}
