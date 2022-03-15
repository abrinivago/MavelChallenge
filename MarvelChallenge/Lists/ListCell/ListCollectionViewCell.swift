//
//  ListCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import UIKit
import Alamofire
import PINRemoteImage

class ListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var listImage: UIImageView!
    @IBOutlet weak var listTitle: UILabel!
    @IBOutlet weak var listStackView: UIStackView!
    @IBOutlet weak var listView: UIView!
    @IBOutlet weak var lisDescription: UILabel!
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCell()
    }
    
    func imageEventMode() {
        imageWidth.constant = 86
        imageHeight.constant = 86
    }
    
    func setupCell(){        
        listImage.contentMode = .scaleToFill
        
        contentView.layer.cornerRadius = 4.0
        contentView.layer.masksToBounds = true
        
        layer.cornerRadius = 4.0
        layer.masksToBounds = false
        
        layer.shadowRadius = 3.0
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 1)
    }
}

