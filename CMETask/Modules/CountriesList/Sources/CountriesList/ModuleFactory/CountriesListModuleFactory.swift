//
//  CountriesListModuleFactory.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation
import Networking
import Common

public class CountriesListModuleFactory {

    @MainActor
    public static func makeModule(
        with coordinator: CountriesListCoordinatorProtocol
    ) -> CountriesListView {
        let baseAPIClient = BaseAPIClient()
        let countriesListAPIClient = CountriesListAPIClient(client: baseAPIClient)
        let countriesListRepository = CountriesListRepository(client: countriesListAPIClient)
        let useCase = CountriesListUseCase(countriesListRepository: countriesListRepository)
        let viewModel = CountriesListViewModel(
            useCase: useCase,
            coordinator: coordinator
        )
        let view = CountriesListView(viewModel: viewModel)
        return view
    }
}
