//
//  MainCoordinator.swift
//  CMETask
//
//  Created by Hesham Aly on 07/01/2025.
//

import UIKit
import SwiftUI
import CountriesList

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

  func showDetails(for country: String) {

  }
}
