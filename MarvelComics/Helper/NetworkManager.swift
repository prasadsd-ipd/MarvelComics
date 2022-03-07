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
}

class NetworkManager {
        
    private func createRequest(for url: URL, method httpMethod: String) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }
    
    private func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, ComicsDataError?)-> Void)?) {
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
                completion?(nil, .noComicData)
            }
        }
        dataTask.resume()
    }
    
    func getComicsData(completion: DidFetchDataCompletion?) {
        
        guard let request = createRequest(for: APIConstants.getCharactersURL(), method: "GET") else {
            completion?(nil, .invalidURL)
            return
        }
        executeRequest(request: request, completion: completion)
    }
}
