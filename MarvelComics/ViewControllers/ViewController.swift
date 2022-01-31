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
        
    }

    //MARK:- Custom Methods
    private func setupViewModel(with viewModel: ComicViewModel) {
        viewModel.didFetchDataCompletion = { [weak self] (error) in
            if error != nil {
                self?.showAlert(of: .noDataAvailable)
            } else {
                DispatchQueue.main.async {
                    self?.comicsTableView.reloadData()
                }
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

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.totalComics ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ComicTableViewCell.reuseIdentifier, for: indexPath) as! ComicTableViewCell
        
        guard let viewModel = viewModel else {
            fatalError("No View Model Present")
        }
        
        // Configuring cell
        cell.configure(with: viewModel.cellViewModel(for: indexPath.row))
        
        return cell
    }
    
    
}
