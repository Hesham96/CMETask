//
//  SearchBar.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI

struct SearchBar: View {
    @ObservedObject var viewModel: CountriesListViewModel

    var body: some View {
        HStack {
            TextField("Search For Countries", text: $viewModel.filterText)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if !viewModel.filterText.isEmpty {
                            Button(action: {
                                viewModel.clearFilter()
                            }) {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
        }
        .padding(.top, 10)
    }
}
