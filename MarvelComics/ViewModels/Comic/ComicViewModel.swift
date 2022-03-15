//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//


import Foundation

typealias DidFetchDataCompletion = (IssuesResponse?, ComicsDataError?) -> Void

protocol ViewModelDelegate: AnyObject {
    func dataFetchComplete (error: Error?)
}

class ComicViewModel {
    
    //MARK:- Properties
    
    private var didFetchDataCompletion: DidFetchDataCompletion?
    
    weak var delegate: ViewModelDelegate?
    
    let networkManager: ComicNetworkHandler
    
    var comicsList: [Result]?
    
    var totalComics: Int {
        return comicsList?.count ?? 0
    }
    
    //MARK:- Initialization
    
    init(with manager: ComicNetworkHandler) {
        self.networkManager = manager
        fetchComicData()
    }
    
    func cellViewModel(for index: Int) -> ComicCellViewModel? {
        return ComicCellViewModel(comicData: (comicsList?[index]))
    }
    
    //MARK:- Helper Methods
    /// Fetches Comics list
    func fetchComicData() {
        
        networkManager.getComicsData { [weak self] response, error in
            guard let issuesResponse = response else {
                if let error = error {
                    self?.delegate?.dataFetchComplete(error: error as? Error)
                }
                return
            }
            self?.comicsList = issuesResponse.results
            self?.delegate?.dataFetchComplete(error: nil)
        }
    }
}
