//
//  NetworkManager.swift
//  MarvelComics
//
//  Created by Imgadmin on 12/02/22.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case invalidData
    case noData
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func createRequest(for url: URL, method httpMethod: String) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, Error?) -> Void)?) {
        let session = URLSession(configuration: .default)
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion?(nil, NetworkError.noData)
                return
            }
            if let decodedResponse = try? JSONDecoder().decode(T.self, from: data) {
                DispatchQueue.main.async {
                    completion?(decodedResponse, nil)
                }
            } else {
                completion?(nil, NetworkError.invalidData)
            }
        }
        dataTask.resume()
    }
}
