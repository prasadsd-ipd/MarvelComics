//
//  Protocols.swift
//  MarvelComics
//
//  Created by Imgadmin on 15/03/22.
//

import Foundation

protocol ComicNetworkHandler {
    
    func createRequest(for url: URL, method httpMethod: String) -> URLRequest?
    func executeRequest<T: Codable>(request: URLRequest, completion: ((T?, ComicsDataError?)-> Void)?)
    func getComicsData(completion: DidFetchDataCompletion?)
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ())
    
}

extension ComicNetworkHandler {
    
    func createRequest(for url: URL, method httpMethod: String) -> URLRequest? {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        return request
    }

    func getComicsData(completion: DidFetchDataCompletion?) {
        
        guard let request = createRequest(for: APIConstants.getCharactersURL(), method: "GET") else {
            completion?(nil, .invalidURL)
            return
        }
        executeRequest(request: request, completion: completion)
    }
    
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

}
