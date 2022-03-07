//
//  ViewController.swift
//  MarvelComics
//
//  Created by Imgadmin on 26/01/22.
//

import UIKit

class ViewController: UIViewController, ViewModelDelegate {

    //MARK:- Properties
    @IBOutlet weak var comicsTableView: UITableView!

    var viewModel: ComicViewModel? {
        didSet {
            guard let viewModel = viewModel else {
                return
            }
            viewModel.delegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    //MARK:- Custom Methods
    ///Delegate method to responde on API response.
    func dataFetchComplete(success: Bool) {
        if success {
            self.comicsTableView.reloadData()
        } else {
            self.showAlert(of: .noDataAvailable)
        }
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
        cell.configure(with: viewModel.cellViewModel(for: indexPath.row) ?? ComicCellViewModel())
        
        return cell
    }
}

extension UIViewController {
    
    //MARK:- Types
    enum Alerts {
        case noDataAvailable
    }

    ///Helper mehtod to show alerts
    func showAlert(of type: Alerts) {
        var title: String
        var message: String
        
        switch type {
        case .noDataAvailable:
            title = StringConstants.noDataTitle
            message = StringConstants.noDataMessage
        }
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true)
    }
}
