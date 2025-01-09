//
//  CountriesListUseCaseMock.swift
//  CountriesList
//
//  Created by Hesham Aly on 09/01/2025.
//

import Foundation
import Combine
import CountriesList
import Networking

final class CountriesListUseCaseMock: CountriesListUseCaseProtocol {

    var mockResponse: Result<CountriesListItems, ModuleError>?

    func fetchCountries() -> AnyPublisher<CountriesListItems, ModuleError> {
        guard let response = mockResponse else {
            return Fail(error: .server).eraseToAnyPublisher()
        }
        return Future { promise in
            promise(response)
        }.eraseToAnyPublisher()
    }
}
