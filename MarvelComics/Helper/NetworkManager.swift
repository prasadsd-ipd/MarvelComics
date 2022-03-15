//
//  NetworkManager.swift
//  MarvelComics
//
//  Created by Imgadmin on 12/02/22.
//

import Foundation

enum ComicsDataError {
    case noComicData
    case invalidURL
    case invalidJson
}

class NetworkManager: ComicNetworkHandler {
            
    func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, ComicsDataError?)-> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, .noComicData)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(IssuesResponse.self, from: data) {
                DispatchQueue.main.async {
                    debugPrint("response: \(decodedResponse)")
                    completion?(decodedResponse as? T, nil)
                }
            } else {
                completion?(nil, .invalidJson)
            }
        }
        dataTask.resume()
    }
    
}
