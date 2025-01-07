//
//  CountriesListView.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI

struct CountryItem {
    let id: Int
    var title: String

    init(id: Int, title: String) {
        self.id = id
        self.title = title
    }
}

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
                ScrollView(showsIndicators: false) {
                    LazyVGrid(
                        columns: viewModel.columnsGrids, spacing: 12) {
                            ForEach(viewModel.countries, id: \.id) { country in
                                VStack(alignment: .leading) {
                                    CountryCardView(image: "star", title: country.title)
                                }
                                .frame(maxWidth: .infinity)
                                .onTapGesture {
                                    // TODO: - Load data
                                    print("Item Did Tapped")
                                }
                                .onAppear {
                                    // TODO: - Paginate
                                }
                            }
                        }
                }
                .padding(12)
            }
            .navigationTitle("Discover The World!")
        }
        .onAppear {
            // TODO: - Load data
        }
    }
}
