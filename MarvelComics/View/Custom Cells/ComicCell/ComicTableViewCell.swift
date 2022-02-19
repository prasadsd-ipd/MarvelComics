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
    @IBOutlet weak var comicDescription: UITextView!
    
    // MARK: - Initialization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(with result: ComicCellViewModel) {

        comicTitle.text = result.name
        comicAlaises.text = result.aliases
        comicDescription.text = result.deck
        comicImageView?.loadThumbnail(urlString: result.image)
    }
}
