import XCTest
import Combine
import Networking
import Common

@testable import CountriesList

final class CountriesListViewModelTests: XCTestCase {

    // MARK: - Properties

    private var viewModel: CountriesListViewModel!
    private var useCaseMock: CountriesListUseCaseMock!
    private var coordinatorMock: CountriesListCoordinatorMock!
    private var cancellables: Set<AnyCancellable>!

    // MARK: - Setup

    override func setUp() {
        super.setUp()
        useCaseMock = CountriesListUseCaseMock()
        coordinatorMock = CountriesListCoordinatorMock()
        viewModel = CountriesListViewModel(useCase: useCaseMock, coordinator: coordinatorMock)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        useCaseMock = nil
        coordinatorMock = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - BDD Test Cases

    func testGetCountriesSuccess() {
        // Given
        let mockCountries = [
            CountryItem(
                name: "Egypt",
                capital: "Cairo",
                region: "Africa",
                flagImageURL: nil,
                countryCode: "EG",
                currency: "EGP",
                population: "100_000_000"
            ),
            CountryItem(
                name: "Germany",
                capital: "Berlin",
                region: "Europe",
                flagImageURL: nil,
                countryCode: "DE",
                currency: "EUR",
                population: "80_000_000"
            )        ]
        useCaseMock.mockResponse = .success(CountriesListItems(countries: mockCountries))

        // When
        viewModel.getCountries()

        // Then
        XCTAssertEqual(viewModel.countries, mockCountries)
        XCTAssertEqual(viewModel.filteredCountries, mockCountries)
        XCTAssertFalse(viewModel.isLoading)
    }

    func testGetCountriesFailure() {
        // Given
        useCaseMock.mockResponse = .failure(.server)

        // When
        viewModel.getCountries()

        // Then
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertTrue(viewModel.countries.isEmpty)
        XCTAssertTrue(viewModel.filteredCountries.isEmpty)
    }

    func testFilterCountries() {
        // Given
        let mockCountries = [
            CountryItem(
                name: "Egypt",
                capital: "Cairo",
                region: "Africa",
                flagImageURL: nil,
                countryCode: "EG",
                currency: "EGP",
                population: "100_000_000"
            ),
            CountryItem(
                name: "Germany",
                capital: "Berlin",
                region: "Europe",
                flagImageURL: nil,
                countryCode: "DE",
                currency: "EUR",
                population: "80_000_000"
            )
        ]
        viewModel.countries = mockCountries
        viewModel.filterText = "Eg"

        // When
        viewModel.filter()

        // Then
        XCTAssertEqual(viewModel.filteredCountries.count, 1)
        XCTAssertEqual(viewModel.filteredCountries.first?.name, "Egypt")
    }

    func testClearFilter() {
        // Given
        let mockCountries = [
            CountryItem(
                name: "Egypt",
                capital: "Cairo",
                region: "Africa",
                flagImageURL: nil,
                countryCode: "EG",
                currency: "EGP",
                population: "100_000_000"
            )
        ]
        viewModel.countries = mockCountries
        viewModel.filteredCountries = mockCountries
        viewModel.filterText = "Eg"

        // When
        viewModel.clearFilter()

        // Then
        XCTAssertEqual(viewModel.filteredCountries, mockCountries)
        XCTAssertEqual(viewModel.filterText, "")
    }

    func testAddToPinnedCountries() {
        // Given
        let country = CountryItem(
            name: "Egypt",
            capital: "Cairo",
            region: "Africa",
            flagImageURL: nil,
            countryCode: "EG",
            currency: "EGP",
            population: "100_000_000"
        )

        // When
        viewModel.addToPinnedCountries(country)

        // Then
        XCTAssertEqual(viewModel.pinnedCountries.count, 1)
        XCTAssertEqual(viewModel.pinnedCountries.first, country)
    }

    func testRemovePinnedCountry() {
        // Given
        let country = CountryItem(
            name: "Egypt",
            capital: "Cairo",
            region: "Africa",
            flagImageURL: nil,
            countryCode: "EG",
            currency: "EGP",
            population: "100_000_000"
        )
        viewModel.pinnedCountries = [country]

        // When
        viewModel.removePinnedCountry(at: IndexSet(integer: 0))

        // Then
        XCTAssertTrue(viewModel.pinnedCountries.isEmpty)
    }

    func testShowCountryDetails() {
        // Given
        let country = CountryItem(
            name: "Egypt",
            capital: "Cairo",
            region: "Africa",
            flagImageURL: nil,
            countryCode: "EG",
            currency: "EGP",
            population: "100_000_000"
        )

        // When
        viewModel.showCountryDetails(for: country)

        // Then
        XCTAssertEqual(coordinatorMock.shownCountryName, country.name)
    }
}
