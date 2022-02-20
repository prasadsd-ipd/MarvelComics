//
//  URLConstants.swift
//  MarvelComics
//
//  Created by Imgadmin on 26/01/22.
//

import Foundation

struct APIConstants {
    
    private static let scheme = "https"
    private static let host = "comicvine.gamespot.com"
    private static let apiKey = "d5b4f817d44b65b1d8cfcea1f103afe7b409ebb4"
    
    static func getCharactersURL() -> URL {
        return createURLFrom(path: "/api/characters/", andQueries: [
            URLQueryItem(name: "field_list", value: "name,deck,aliases,image"),
        ])
    }
    
    private static func createURLFrom(path: String, andQueries: [URLQueryItem]) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = path
        components.queryItems = [URLQueryItem(name: "api_key", value: apiKey),
                                 URLQueryItem(name: "format", value: "json")]
        components.queryItems?.append(contentsOf: andQueries)
        return components.url!
    }
}

