//
//  ViewController.swift
//  MarvelComics
//
//  Created by Imgadmin on 26/01/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var defaultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let request = URLRequest(url: APIConstants.apiURL!)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                debugPrint(error)
                DispatchQueue.main.async {
                    self?.defaultLabel.text = "Error with response"
                }
            } else if let data = data {
                do {
                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                    debugPrint(result as Any)
                    DispatchQueue.main.async {
                        self?.defaultLabel.text = "Data Downloaded"
                    }
                } catch let error as NSError {
                    debugPrint(error)
                    DispatchQueue.main.async {
                        self?.defaultLabel.text = "Error while parsing"
                    }
                }
            }
        }.resume()
    }


}

