//
//  CountriesListViewModel.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI
import Combine

final class CountriesListViewModel: ObservableObject {

    // MARK: - Properties

    let columnsGrids = Array(repeating: GridItem(.flexible()), count: 1)
    @Published var countries: [CountryItem] = [CountryItem(id: 1, title: "Egypt"),
                                    CountryItem(id: 2, title: "Saudi Arabia"),
                                    CountryItem(id: 3, title: "Dubai")
    ]

    init() {
        
    }

    
}
