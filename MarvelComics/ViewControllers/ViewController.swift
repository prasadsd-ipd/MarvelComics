//
//  ViewController.swift
//  MarvelComics
//
//  Created by Imgadmin on 26/01/22.
//

import UIKit

class ViewController: UIViewController {

    //MARK:- Types
    private enum Alerts {
        case noDataAvailable
    }

    //MARK:- Properties
    @IBOutlet weak var comicsTableView: UITableView!

    var viewModel: ComicViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            setupViewModel(with: viewModel)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let request = URLRequest(url: APIConstants.apiURL!)
        URLSession.shared.dataTask(with: request) { [weak self] (data, response, error) in
            if let error = error {
                debugPrint(error)
            } else if let data = data {
                do {
                    let issuesResponse = try JSONDecoder().decode(IssuesResponse.self, from: data)
                    let results = issuesResponse.results
                    for result in results {
                        print("\(result.name) - \(String(describing: result.aliases))\n\(result.deck)")
                    }
//                    let result = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
//                    debugPrint(result as Any)
//                    DispatchQueue.main.async {
//                        self?.defaultLabel.text = "Data Downloaded"
//                    }
                } catch let error as NSError {
                    debugPrint(error)
//                    DispatchQueue.main.async {
//                        self?.defaultLabel.text = "Error while parsing"
//                    }
                }
            }
        }.resume()
    }

    //MARK:- Custom Methods
    private func setupViewModel(with viewModel: ComicViewModel) {
        viewModel.didFetchDataCompletion = { [weak self] (error) in
            if error != nil {
                self?.showAlert(of: .noDataAvailable)
            } else {
                self?.comicsTableView.reloadData()
            }
        }
    }

    ///Helper mehtod to show alerts
    private func showAlert(of type: Alerts) {
        let title: String
        let message: String
        
        switch type {
        case .noDataAvailable:
            title = "Unable to fetch data"
            message = "The application is unable to fetch data. Please check your network connection."
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }

}

