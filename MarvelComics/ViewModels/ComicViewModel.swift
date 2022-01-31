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
        case noImageData
    }
    
    typealias DidFetchDataCompletion = (ComicsDataError?) -> Void

    //MARK:- Properties
    
    var didFetchDataCompletion: DidFetchDataCompletion?
    
    var comicsList: [ComicRepresentable]?
    
    var totalComics: Int {
        return comicsList?.count ?? 0
    }
    
    //MARK:- Initialization
    
    init() {

    }
        
    func dateFormatter(_ date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        guard let requiredDate = dateFormatter.date(from: date) else { return date }
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: requiredDate)
    }
}
