//
//  TitleCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 10/03/2022.
//

import UIKit

class TitleCollectionViewCell: UICollectionViewCell {
    var titleLbl: UILabel!
    var titleValue: String! {
        didSet {
            setupLabel(titleValue)
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupLabel(_ value: String) {
        titleLbl = UILabel()
        titleLbl.text = value
        titleLbl.numberOfLines = 0
        titleLbl.font = UIFont(name: "RobotoCondensed-Regular", size: 26)
        self.addSubview(titleLbl!)
        setuptitleLblConstraints()
    }
    
    func setuptitleLblConstraints(){
        titleLbl.translatesAutoresizingMaskIntoConstraints = false
        titleLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 14).isActive = true
        titleLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
