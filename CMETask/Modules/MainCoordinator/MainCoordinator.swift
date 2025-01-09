//
//  MainCoordinator.swift
//  CMETask
//
//  Created by Hesham Aly on 07/01/2025.
//

import UIKit
import SwiftUI
import Common
import CountriesList
import CountryDetails

class MainCoordinator {
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }
}

// MARK: - CountriesListCoordinatorProtocol

extension MainCoordinator: @preconcurrency CountriesListCoordinatorProtocol {
  @MainActor
  func start() {
    let countriesListView = CountriesListModuleFactory.makeModule(with: self)
    let hostingController = UIHostingController(rootView: countriesListView)
    navigationController.setViewControllers([hostingController], animated: false)
  }

  func goBack() {
    navigationController.popViewController(animated: true)
  }

    @MainActor
    func showCountryDetails(
        name: String?,
        capital: String?,
        population: String?,
        region: String?,
        currency: String?,
        flagImageURL: String?
    ) {
        let countryDetailView = CountryDetailsModuleFactory.makeModule(
            with: self,
            name: name,
            capital: capital,
            population: population,
            region: region,
            currency: currency,
            flagImageURL: flagImageURL
        )
        let hostingController = UIHostingController(rootView: countryDetailView)
        navigationController.pushViewController(hostingController, animated: true)
    }
}
