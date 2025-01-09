//
//  CountriesListViewModel.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI
import Combine
import Common

final class CountriesListViewModel: ObservableObject {

    // MARK: - Properties

    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 1)
    @Published var isLoading = false
    @Published var countries: [CountryItem] = []
    @Published var filteredCountries: [CountryItem] = []
    @Published var pinnedCountries: [CountryItem] = []
    @Published var filterText = ""
    @Published var userCountry: CountryItem?
    @Published var locationPermissionDenied = false

    private var locationManager = LocationManager()
    private var useCase: CountriesListUseCaseProtocol
    private var coordinator: CountriesListCoordinatorProtocol
    private var cancellable: Set<AnyCancellable> = []

    init(
        useCase: CountriesListUseCaseProtocol,
        coordinator: CountriesListCoordinatorProtocol
    ) {
        self.useCase = useCase
        self.coordinator = coordinator
        addObservers()
        locationManager.fetchLocation()
        getCountries()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Privates

    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(self.handleLocationPermission(_:)),
                                               name: .locationAuthorization,
                                               object: nil)
    }

    @objc
    func handleLocationPermission(_ notification: NSNotification) {
        if let isAuthorized = notification.userInfo?["isAuthorized"] as? Bool {
            if isAuthorized {
                locationManager.$userCountry
                    .sink { [weak self] countrCode in
                        guard let self = self, let countrCode else { return }
                        self.userCountry = self.countries.first { $0.countryCode == countrCode }
                    }
                    .store(in: &cancellable)

                locationManager.$locationPermissionDenied
                    .assign(to: &$locationPermissionDenied)

                handleUserCountry()
            } else {
                handleUserCountry()
            }
        }
    }

    private func handleUserCountry() {
        if let userCountryCode = self.locationManager.userCountry {
            self.userCountry = self.countries.first { $0.countryCode == userCountryCode }
        } else {
            self.userCountry = self.countries.filter({$0.name == "Egypt"}).first
        }
    }

    // MARK: - Public

    func getCountries() {
        isLoading = true
        useCase.fetchCountries()
            .sink { [weak self] completion in
                guard let self = self else { return }
                if case .failure = completion {
                    /// Handle errors (e.g., network issues)
                    /// Perform Caching logic
                }
                self.isLoading = false
            } receiveValue: { [weak self] response in
                guard let self = self else { return }
                self.countries = response.countries
                self.filteredCountries = self.countries
                self.isLoading = false
                self.handleUserCountry()
            }
            .store(in: &cancellable)
    }

    func filter() {
        if filterText.isEmpty {
            clearFilter()
        } else {
            filteredCountries = countries.filter { $0.name?.starts(with: filterText) ?? false }
        }
    }

    func clearFilter() {
        filterText = ""
        filteredCountries = countries
    }

    func removeCountry(at offset: IndexSet) {
        countries.remove(atOffsets: offset)
        filteredCountries.remove(atOffsets: offset)
    }

    func addToPinnedCountries(_ country: CountryItem) {
        if !pinnedCountries.contains(where: { $0.id == country.id }),
           pinnedCountries.count < 5 {
            pinnedCountries.append(country)
        } else {
            print("Country is already pinned: \(country.name ?? "Unknown")")
        }
    }

    func removePinnedCountry(at offset: IndexSet) {
        pinnedCountries.remove(atOffsets: offset)
    }

    func showCountryDetails(for country: CountryItem) {
        coordinator.showCountryDetails(
            name: country.name,
            capital: country.capital,
            population: country.population,
            region: country.region,
            currency: country.currency,
            flagImageURL: country.flagImageURL
        )
    }
}
