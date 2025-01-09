//
//  CountriesListView.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI

public struct CountriesListView: View {

    // MARK: -  Properties

    @StateObject private var viewModel: CountriesListViewModel

    // MARK: - Initializer

    init(viewModel: CountriesListViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - Views

    public var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView()
                } else {
                    SearchBar(viewModel: viewModel)
                    List {
                        // User's Country Section
                        if let userCountry = viewModel.userCountry {
                            Section(header: Text("Your Country")) {
                                CountryCardView(flagURL: userCountry.flagImageURL ?? "",
                                                title: userCountry.name ?? "")
                                .onTapGesture {
                                    viewModel.showCountryDetails(for: userCountry)
                                }
                                .listRowSeparator(.hidden)
                                .padding([.leading, .trailing], -16)
                            }
                        }

                        if viewModel.pinnedCountries.count > 0 {
                            // Pinned Countries Section
                            Section(header: Text("Pinned Countries")) {
                                ForEach(viewModel.pinnedCountries, id: \.id) { country in
                                    CountryCardView(flagURL: country.flagImageURL ?? "",
                                                    title: country.name ?? "")
                                    .onTapGesture {
                                        viewModel.showCountryDetails(for: country)
                                    }
                                }
                                .onDelete(perform: viewModel.removePinnedCountry)
                                .listRowSeparator(.hidden)
                                .padding([.leading, .trailing], -16)
                            }
                        }

                        // World's Countries Section
                        Section(header: Text("World's Countries")) {
                            ForEach(viewModel.filteredCountries, id: \.id) { country in
                                CountryCardView(flagURL: country.flagImageURL ?? "",
                                                title: country.name ?? "")
                                .swipeActions(edge: .leading) {
                                    Button {
                                        viewModel.addToPinnedCountries(country)
                                    } label: {
                                        Label("Pin", systemImage: "pin")
                                    }
                                    .tint(.green)
                                }
                                .onTapGesture {
                                    viewModel.showCountryDetails(for: country)
                                }
                            }
                            .onDelete(perform: viewModel.removeCountry)
                            .listRowSeparator(.hidden)
                            .padding([.leading, .trailing], -16)
                        }
                    }
                    .listStyle(PlainListStyle())
                    .background(Color.white)
                    .onChange(of: viewModel.filterText) { _ in
                        viewModel.filter()
                    }
                }
            }
            .background(Color.white)
            .navigationTitle("Discover The World!")
        }
        .background(Color.white.ignoresSafeArea())
    }
}
