//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//


import Foundation

class ComicViewModel {
    
    //MARK:- Types
    
    enum ComicsDataError {
        case noComicData
    }
    
    typealias DidFetchDataCompletion = (ComicsDataError?) -> Void

    //MARK:- Properties
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    
    var comicsList: [Result]?
    
    var totalComics: Int {
        return comicsList?.count ?? 0
    }
    
    //MARK:- Initialization
    
    init() {
        fetchComicData()
    }
    func cellViewModel(for index: Int) -> ComicCellViewModel {
        return ComicCellViewModel(comicData: (comicsList?[index])!)
    }
    
    //MARK:- Helper Methods
    /// Fetches Comics list
    func fetchComicData() {
        let comicsRequest = URLRequest(url: APIConstants.apiURL!)
        URLSession.shared.dataTask(with: comicsRequest) { [weak self] (data, response, error) in
            if let error = error {
                debugPrint("Request failed with \(error)")
                self?.didFetchDataCompletion?(.noComicData)
            } else if let data = data {
                do {
                    let issuesResponse = try JSONDecoder().decode(IssuesResponse.self, from: data)
                    self?.comicsList = issuesResponse.results
                    self?.didFetchDataCompletion?(nil)
                } catch let error as NSError {
                    debugPrint("Parsing failed with \(error)")
                }
            }
        }.resume()
    }
}
