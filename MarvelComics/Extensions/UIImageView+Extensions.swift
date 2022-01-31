//
//  UIImageView+Extensions.swift
//  MarvelComics
//
//  Created by Imgadmin on 30/01/22.
//

import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    /// This loadThumbnail function is used to download thumbnail image using urlString
    /// This method also using cache of loaded thumbnail using urlString as a key of cached thumbnail.
    func loadThumbnail(urlString: String) {
        
        let newUrlString = urlString.replacingOccurrences(of: "/", with: "")
        debugPrint(newUrlString)
        guard let url = URL(string: newUrlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: newUrlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                guard let imageToCache = UIImage(data: data) else { return }
                imageCache.setObject(imageToCache, forKey: newUrlString as AnyObject)
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
    }
}
