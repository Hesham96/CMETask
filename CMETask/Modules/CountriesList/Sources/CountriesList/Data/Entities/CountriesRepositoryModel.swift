//
//  CountriesRepositoryModel.swift
//  CountriesList
//
//  Created by Hesham Aly on 07/01/2025.
//


import Foundation

struct CountriesRepositoryModel {
  let countries: [CountryRepositoryModel]?
}

struct CountryRepositoryModel {
    let name: String?
    let capital: String?
    let region: String?
    let flag: String?
    let countryCode: String?
    let currency: String?
    let population: String?
}
