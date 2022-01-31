//
//  ComicCellViewModelTests.swift
//  MarvelComicsTests
//
//  Created by Imgadmin on 31/01/22.
//

import XCTest
@testable import MarvelComics

class ComicCellViewModelTests: XCTestCase {
    
    // MARK: - Properties
    var viewModel: ComicCellViewModel!
    
    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "ResponseTestData", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Initialize  Response
        let comics = try! decoder.decode(IssuesResponse.self, from: data)

        viewModel = ComicCellViewModel(comicData: comics.results[8])

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testName() {
        XCTAssertEqual(viewModel.name, "Tyrannosaurus")
    }
    
    func testAliases() {
        XCTAssertEqual(viewModel.aliases, "Tyrannosaur")
    }

}
