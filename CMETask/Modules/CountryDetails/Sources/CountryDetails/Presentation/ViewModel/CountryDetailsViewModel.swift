//
//  CountryDetailsViewModel.swift
//  CountryDetails
//
//  Created by Hesham Aly on 08/01/2025.
//

import SwiftUI
import Common

final class CountryDetailsViewModel: ObservableObject {

    // MARK: - Properties

    private var coordinator: CountriesListCoordinatorProtocol

    // MARK: - Init

    init(coordinator: CountriesListCoordinatorProtocol) {
        self.coordinator = coordinator
    }

    // MARK: - Public

    func goBack() {
        coordinator.goBack()
    }
}
