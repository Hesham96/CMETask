//
//  CountriesNetworkResponse.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//

import Foundation

// MARK: - CountryNetworkResponse

struct CountryNetworkResponse: Codable {
    let name: String?
    let capital: String?
    let region: String?
    let flag: String?
    let alpha2Code: String?
    let currency: String?
    let population: Int?

    enum CodingKeys: String, CodingKey {
        case name,
             capital,
             region,
             flags,
             alpha2Code,
             currencies,
             population
    }

    enum FlagsKeys: String, CodingKey {
        case png
    }

    enum CurrenciesKeys: String, CodingKey {
        case name
    }


    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        capital = try container.decodeIfPresent(String.self, forKey: .capital)
        region = try container.decodeIfPresent(String.self, forKey: .region)
        alpha2Code = try container.decodeIfPresent(String.self, forKey: .alpha2Code)
        population = try container.decodeIfPresent(Int.self, forKey: .population)
        if let flagsContainer = try? container.nestedContainer(keyedBy: FlagsKeys.self,
                                                               forKey: .flags) {
            flag = try flagsContainer.decodeIfPresent(String.self, forKey: .png)
        } else {
            flag = nil
        }

        if let currenciesArray = try? container.decodeIfPresent([CurrencyNetworkResponse].self,
                                                                forKey: .currencies) {
            currency = currenciesArray.first?.name
        } else {
            currency = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(capital, forKey: .capital)
        try container.encodeIfPresent(region, forKey: .region)
        try container.encodeIfPresent(population, forKey: .population)

        if let flag = flag {
            var flagsContainer = container.nestedContainer(keyedBy: FlagsKeys.self,
                                                           forKey: .flags)
            try flagsContainer.encode(flag, forKey: .png)
        }

        if let currency = currency {
            let currenciesArray = [CurrencyNetworkResponse(name: currency)]
            try container.encode(currenciesArray, forKey: .currencies)
        }
    }
}

// MARK: - Currency

struct CurrencyNetworkResponse: Codable {
    let name: String?
}
