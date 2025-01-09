//
//  SwiftUIView.swift
//  CountryDetails
//
//  Created by Hesham Aly on 08/01/2025.
//

import SwiftUI
import Kingfisher

public struct CountryDetailsView: View {

    // MARK: -  Properties

    @StateObject private var viewModel: CountryDetailsViewModel

    private let countryName: String
    private let capital: String
    private let population: String
    private let region: String
    private let currency: String
    private let flagImageURL: String

    // MARK: - Initializer

    init(
        viewModel: CountryDetailsViewModel,
        name: String?,
        capital: String?,
        population: String?,
        region: String?,
        currency: String?,
        flagImageURL: String?
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.countryName = name ?? ""
        self.capital = capital ?? ""
        self.population = population ?? ""
        self.region = region ?? ""
        self.currency = currency ?? ""
        self.flagImageURL = flagImageURL ?? ""
    }

    //  MARK: - Views

    public var body: some View {
        ZStack {

            VStack(spacing: 20) {
                // Header
                Text(countryName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.top, 16)

                // Image
                KFImage(URL(string: flagImageURL))
                    .placeholder {
                        Circle()
                            .foregroundColor(.gray)
                    }
                    .retry(maxCount: 3, interval: .seconds(5))
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 120)
                    .cornerRadius(10)

                // Details Section
                VStack(alignment: .leading, spacing: 8) {
                    detailRow(label: "Capital", value: capital)
                    detailRow(label: "Population", value: population)
                    detailRow(label: "Region", value: region)
                    detailRow(label: "Currency", value: currency)
                }
                .padding()
                .background(Color.white)
                .cornerRadius(16)
                .shadow(color: Color.gray.opacity(0.5), radius: 8, x: 0, y: 4)
                .padding(.horizontal)
                .padding(.bottom, 64)

                // Back Button
                Button(action: {
                    viewModel.goBack()
                }) {
                    Text("Back To Discover The World!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.bottom, 16)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(30)
            .shadow(radius: 10)
            .padding(.horizontal)
        }
    }

    private func detailRow(label: String, value: String) -> some View {
        HStack {
            Text("\(label):")
                .fontWeight(.regular)
                .foregroundColor(.black)

            Spacer()

            Text(value)
                .fontWeight(.bold)
                .foregroundColor(.black)
        }
        .padding(.vertical, 4)
        .overlay(Divider(), alignment: .bottom)
    }
}
