//
//  ComicRepresentable.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import UIKit

protocol ComicRepresentable {
    
    var title: String { get }
    var aliases: String { get }
    var deck: String { get }
    var imagePath: String { get }
}
