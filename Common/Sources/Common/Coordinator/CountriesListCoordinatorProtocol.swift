//
//  CountriesListCoordinatorProtocol.swift
//  Common
//
//  Created by Hesham Aly on 08/01/2025.
//

import Foundation

public protocol CountriesListCoordinatorProtocol {
    func start()
    func goBack()
    func showCountryDetails(name: String?,
                            capital: String?,
                            population: String?,
                            region: String?,
                            currency: String?,
                            flagImageURL: String?)
}
