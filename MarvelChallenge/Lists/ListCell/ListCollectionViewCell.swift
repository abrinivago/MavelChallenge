//
//  ListCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import UIKit
import Alamofire

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var lisDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 4.0
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 4.0
        layer.masksToBounds = false

        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
    
//    func eventsImageSize() {
//    }
}

