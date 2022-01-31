//
//  IssuesModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import Foundation

// MARK: - IssuesResponse
struct IssuesResponse: Codable {
    let error: String
    let limit, offset, numberOfPageResults, numberOfTotalResults: Int
    let statusCode: Int
    let results: [Result]
    let version: String

    enum CodingKeys: String, CodingKey {
        case error, limit, offset
        case numberOfPageResults = "number_of_page_results"
        case numberOfTotalResults = "number_of_total_results"
        case statusCode = "status_code"
        case results, version
    }
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
    let iconURL, mediumURL, screenURL, screenLargeURL: String?
    let smallURL, superURL, thumbURL, tinyURL: String
    let originalURL: String?
    let imageTags: String

    enum CodingKeys: String, CodingKey {
        case iconURL = "icon_url"
        case mediumURL = "medium_url"
        case screenURL = "screen_url"
        case screenLargeURL = "screen_large_url"
        case smallURL = "small_url"
        case superURL = "super_url"
        case thumbURL = "thumb_url"
        case tinyURL = "tiny_url"
        case originalURL = "original_url"
        case imageTags = "image_tags"
    }
}
