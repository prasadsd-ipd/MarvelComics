//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//


import Foundation

typealias DidFetchDataCompletion = (IssuesResponse?, ComicsDataError?) -> Void

protocol ViewModelDelegate: AnyObject {
    func dataFetchComplete (success: Bool, message: String)
}

class ComicViewModel {
    
    //MARK:- Types
    
    //MARK:- Properties
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    
    weak var delegate: ViewModelDelegate?
    
    private var comicsList: [Result]?
    
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
        
        NetworkManager().getComicsData { [weak self] response, error in
            guard let issuesResponse = response else {
                self?.delegate?.dataFetchComplete(success: false, message: "Data load failed")
                return
            }
            self?.comicsList = issuesResponse.results
//            self?.didFetchDataCompletion?(issuesResponse, nil)
            self?.delegate?.dataFetchComplete(success: true, message: "Data loaded")
        }
    }
}
