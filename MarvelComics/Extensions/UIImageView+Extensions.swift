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
        
        guard let url = URL(string: urlString) else { return }
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as AnyObject) {
            image = imageFromCache as? UIImage
            return
        }
        
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            guard let imageToCache = UIImage(data: data) else { return }
            imageCache.setObject(imageToCache, forKey: urlString as AnyObject)
            //Here image is being downloaded asynchronously, So image will be updated on UI via main thread.
            DispatchQueue.main.async() { [weak self] in
                self?.image = imageToCache
            }
        }
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
