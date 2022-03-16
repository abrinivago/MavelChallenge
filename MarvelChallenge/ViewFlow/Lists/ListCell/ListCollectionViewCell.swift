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
    }
    
    func imageEventMode() {
        imageWidth.constant = 86
        imageHeight.constant = 86
    }
    
    func setupCell(isDetail: Bool){
        listImage.contentMode = .scaleToFill
        
        if !isDetail {
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
}

extension ListCollectionViewCell {
    class func buildCellInCollection(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath, resultData: Results, isCharacter: Bool, isDetail: Bool = false) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell
        cell?.setupCell(isDetail: isDetail)
        var titleName: String = ""
        
        if isCharacter {
            titleName = resultData.name ?? ""
            cell?.listTitle.text? = titleName.uppercased()
        } else {
            titleName = resultData.title ?? ""
            cell?.imageEventMode()
            cell?.listTitle.text? = titleName
        }

        cell?.lisDescription.text = resultData.resultDescription
        let pathImage = (resultData.thumbnail?.path)! + "." + (resultData.thumbnail?.thumbnailExtension)!
        cell?.listImage.pin_setImage(from: URL(string: pathImage)!)
        
        return cell ?? ListCollectionViewCell()
    }
}
