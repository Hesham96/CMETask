//
//  CountriesListCoordinatorProtocol.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

public protocol CountriesListCoordinatorProtocol {
    func start()
    func goBack()
    func showDetails(for country: String)
}
