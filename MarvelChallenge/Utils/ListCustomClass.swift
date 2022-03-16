//
//  CustomClass.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 15/03/2022.
//

import Foundation
import UIKit

class ListCustomClass: UIViewController {
    func setupNavBar(title: String) {
        let contentView = UIView()
        contentView.backgroundColor = .black
        contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let label = UILabel()
        contentView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        label.text = title
        label.font = UIFont(name: "RobotoCondensed-Bold", size: 20)
        label.textColor = .white
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalToConstant: 150).isActive = true
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
        tabBarController?.navigationItem.titleView = contentView
    }
}
