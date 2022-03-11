//
//  UIViewController+Extension.swift
//  MarvelComics
//
//  Created by Imgadmin on 10/03/22.
//

import UIKit

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
