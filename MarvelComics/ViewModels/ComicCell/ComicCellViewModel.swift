//
//  ComicCellViewModel.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import UIKit

struct ComicCellViewModel {
    
    // MARK: - Properties
    
    var comicData: Result?
    
    // MARK: -
    var name: String {
        return comicData?.name ?? "No Name"
    }
    
    var aliases: String {
        return comicData?.aliases ?? "No Aliases"
    }
    
    var deck: String {
        return comicData?.deck ?? "Description not available"
    }
    
    var image: String {
        guard let imageurl = comicData?.image!.originalURL else {
            return "No ImageData"
        }
        return imageurl
    }
}
