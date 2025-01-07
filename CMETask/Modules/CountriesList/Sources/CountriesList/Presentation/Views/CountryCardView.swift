//
//  CountryCardView.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import SwiftUI

struct CountryCardView: View {

    // MARK: - Properties

    let image: String
    let title: String

    // MARK: - View

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: image)
                .resizable()
                .frame(width: 32, height: 32)
                .padding(.leading, 8)

            // Title
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

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CountryCardView(image: "star", title: "Sample Title")
            .previewLayout(.sizeThatFits)
            .padding()
    }
}

