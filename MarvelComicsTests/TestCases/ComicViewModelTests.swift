//
//  ComicViewModelTests.swift
//  MarvelComicsTests
//
//  Created by Imgadmin on 31/01/22.
//

import XCTest
@testable import MarvelComics

class ComicViewModelTests: XCTestCase {

    // MARK: - Properties
    var networkManager: MockNetworkManager!
    var viewModel: ComicViewModel!

    override func setUp() {
        super.setUp()
        
        // Initialising properties
        networkManager = MockNetworkManager()
        viewModel = ComicViewModel(with: networkManager)
        
        // Load Stub
        let data = loadStub(name: "ResponseTestData", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Initialize  Response
        let comics = try! decoder.decode(IssuesResponse.self, from: data)

        networkManager.mockedResponse = comics
        viewModel.comicsList = comics.results
        
    }

    override func tearDown() {
        super.tearDown()
    }

    // MARK: - Tests for Number of comics

    func testNumberOfComics() {
        XCTAssertEqual(viewModel.totalComics, 33)
    }

    func testViewModelForIndex() {
        let comicCellViewModel = viewModel.cellViewModel(for: 6)
        
        XCTAssertEqual(comicCellViewModel?.name, "Zepha")
        XCTAssertEqual(comicCellViewModel?.aliases, "No Aliases")
    }

    func testFetchComicData() {
        
        networkManager.getComicsData { response, error in
            XCTAssertNotNil(response)
        }
        
    }
}
