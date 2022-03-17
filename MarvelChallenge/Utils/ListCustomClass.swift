//
//  CustomClass.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 15/03/2022.
//

import Foundation
import UIKit

class ListCustomClass: UIViewController {
    func setupNavBar(title: String = "Marvel Challenge") {
        tabBarController?.navigationItem.titleView = nil
        let contentView = UIView()
        contentView.backgroundColor = .black
        contentView.heightAnchor.constraint(equalToConstant: 40).isActive = true

        let label = UILabel()
        contentView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        label.text = title
        label.textAlignment = .center
        label.font = UIFont(name: "RobotoCondensed-Bold", size: 20)
        label.textColor = .white
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 21).isActive = true
        tabBarController?.navigationItem.titleView = contentView
        tabBarController?.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.44)
    }
    
    func setupRightButton() {
        let closeSessionBtn = UIButton(type: .system)
        closeSessionBtn.setImage(UIImage(systemName: "rectangle.portrait.and.arrow.right"), for: .normal)
        closeSessionBtn.tintColor = .white
        closeSessionBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: closeSessionBtn)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeSessionButton))
        closeSessionBtn.addGestureRecognizer(tapGesture)
    }
    
    @objc func closeSessionButton() {
        UserSession.sessionVerify?.closeSession()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
