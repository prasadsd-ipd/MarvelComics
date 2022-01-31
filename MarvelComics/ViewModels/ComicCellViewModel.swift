//
//  ComicCellViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import UIKit

struct ComicCellViewModel {
    
    // MARK: - Properties
    
    let comicData: ComicRepresentable?
    
    // MARK: -
    var title: String {
        return comicData?.title ?? "Comic Name"
    }
    
    var aliases: String {
        return comicData?.aliases ?? "Other Names"
    }
    
    var deck: String {
        return comicData?.deck ?? "Comic Description"
    }
    
    var imagePath: String {
        return comicData?.imagePath ?? "Comic Poster"
    }
    
}

extension ComicCellViewModel: ComicRepresentable {

}
