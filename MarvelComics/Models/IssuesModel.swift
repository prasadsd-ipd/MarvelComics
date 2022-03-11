//
//  IssuesModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import Foundation

// MARK: - IssuesResponse
struct IssuesResponse: Codable {
    let results: [Result]
}

// MARK: - Result
struct Result: Codable {
    let name: String?
    let aliases: String?
    let deck: String?
    let image: Image?
}

// MARK: - Image
struct Image: Codable {
    let originalURL: String?

    enum CodingKeys: String, CodingKey {
        case originalURL = "original_url"
    }
}
