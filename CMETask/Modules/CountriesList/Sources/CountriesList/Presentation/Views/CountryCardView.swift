//
//  CountryCardView.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI
import Kingfisher

struct CountryCardView: View {

    // MARK: - Properties

    let flagURL: String
    let title: String

    // MARK: - View

    var body: some View {
        HStack(spacing: 12) {
            KFImage(URL(string: flagURL))
                .placeholder {
                    Circle()
                        .foregroundColor(.gray)
                }
              .retry(maxCount: 3, interval: .seconds(5))
              .resizable()
              .aspectRatio(contentMode: .fit)
              .frame(width: 32, height: 32)
              .padding(.leading, 8)

            Text(title)
                .font(.headline)
                .foregroundColor(.primary)

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 50)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }
}
