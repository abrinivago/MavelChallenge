//
//  ImageCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 10/03/2022.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    var characterImage: UIImageView!
    var character: Results! {
        didSet {
            setupImageView()
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupImageView() {
        
        characterImage = UIImageView()
        characterImage.contentMode = .scaleToFill
        characterImage.clipsToBounds = true
        var pathImage = "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg"
        guard let thumb = character.thumbnail?.path,
              let ext = character.thumbnail?.thumbnailExtension else {
                  return
              }
        pathImage = thumb + "." + ext
        characterImage.pin_setImage(from: URL(string: pathImage)!)
        self.addSubview(characterImage)
        setupConstraintsImageView()
    }
    
    func setupConstraintsImageView(){
        characterImage.translatesAutoresizingMaskIntoConstraints = false
        characterImage.heightAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        characterImage.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        characterImage.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        characterImage.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        characterImage.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        characterImage.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
