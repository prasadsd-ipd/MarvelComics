//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//


import Foundation

typealias DidFetchDataCompletion = (IssuesResponse?, ComicsDataError?) -> Void

class ComicViewModel {
    
    //MARK:- Types
    
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
        
        NetworkManager().getComicsData { [weak self] issuesResponse, error in
            self?.comicsList = issuesResponse?.results
            self?.didFetchDataCompletion?(issuesResponse, nil)
        }
    }
}
