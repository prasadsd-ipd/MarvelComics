//
//  ComicTableViewCell.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import UIKit

class ComicTableViewCell: UITableViewCell {
    
    // MARK: - Static Properties
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    //MARK:- Properties
    
    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicAlaises: UILabel!
    @IBOutlet weak var comicDescription: UILabel!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with representable: ComicRepresentable) {

        comicTitle.text = representable.title
        comicAlaises.text = representable.aliases
        comicDescription.text = representable.deck
        comicImageView?.loadThumbnail(urlString: representable.imagePath)
    }
}
