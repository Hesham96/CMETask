//
//  CountriesListModuleFactory.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

public class CountriesListModuleFactory {
    
    @MainActor
    public static func makeModule(
        with coordinator: CountriesListCoordinatorProtocol
    ) -> CountriesListView {
        let viewModel = CountriesListViewModel()
        let view = CountriesListView(viewModel: viewModel)
        return view
    }
}
