//
//  MockNetworkManager.swift
//  MarvelComicsTests
//
//  Created by Imgadmin on 15/03/22.
//

import Foundation
@testable import MarvelComics

class MockNetworkManager: ComicNetworkHandler {
    
    var error : ComicsDataError?
    var mockedResponse : IssuesResponse?
    
    func executeRequest<T>(request: URLRequest, completion: ((T?, ComicsDataError?) -> Void)?) where T : Decodable, T : Encodable {
        switch error {
        case .invalidJson:
            fallthrough
        case .noComicData:
            completion?(nil, error)
        default:
            completion?(mockedResponse as? T, nil)
        }
    }
    
}

