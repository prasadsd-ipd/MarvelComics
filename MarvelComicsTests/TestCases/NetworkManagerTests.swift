//
//  NetworkManagerTests.swift
//  MarvelComicsTests
//
//  Created by Imgadmin on 15/03/22.
//

import XCTest
@testable import MarvelComics

class NetworkManagerTests: XCTestCase {

    let mockNetworkManager = MockNetworkManager()
    
    override func setUp() {
        super.setUp()
        
        // Load Stub
        let data = loadStub(name: "ResponseTestData", extension: "json")
        
        // Initialize JSON Decoder
        let decoder = JSONDecoder()

        // Mocking  Response
        mockNetworkManager.mockedResponse = try! decoder.decode(IssuesResponse.self, from: data)
    }

    func testGetComicsData_Success() {
        mockNetworkManager.error = nil
        mockNetworkManager.getComicsData { data, error in
            XCTAssertNotNil(data)
        }
    }
    
    func testGetComicsData_InvalidJason() {
        mockNetworkManager.error = .invalidJson
        mockNetworkManager.mockedResponse = nil
        mockNetworkManager.getComicsData { response, error in
            XCTAssertEqual(error, .invalidJson)
        }
    }
    
    func testGetComicsData_NoData() {
        mockNetworkManager.error = .noComicData
        mockNetworkManager.mockedResponse = nil
        mockNetworkManager.getComicsData { response, error in
            XCTAssertEqual(error, .noComicData)
        }
    }
}
