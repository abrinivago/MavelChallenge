//
//  Spinner.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 16/03/2022.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)
    
    override func loadView(){
        view = UIView()
        view.backgroundColor = UIColor(white: 1, alpha: 0.9)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
