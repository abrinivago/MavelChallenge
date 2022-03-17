//
//  DescriptionCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 10/03/2022.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    var characterDetail: UILabel!
    var character: Results! {
        didSet {
            setupDescription()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupDescription() {
            characterDetail = UILabel()
            characterDetail.text = character.resultDescription
            characterDetail.numberOfLines = 5
            characterDetail.font = UIFont(name: "RobotoCondensed-Regular", size: 14)
            self.addSubview(characterDetail!)
            setupCharacterDetailConstraints()
    }
    
    func setupCharacterDetailConstraints() {
        characterDetail.translatesAutoresizingMaskIntoConstraints = false
        characterDetail.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        characterDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 43).isActive = true
        characterDetail.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        characterDetail.widthAnchor.constraint(equalToConstant: 255).isActive = true
    }
}
