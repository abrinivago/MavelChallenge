//
//  AppearsCollectionViewCell.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 10/03/2022.
//

import UIKit

class AppearsCollectionViewCell: UICollectionViewCell {
    var titleAppear: UILabel!
    var yearAppear: UILabel!
    var titleAppearsValue: String! {
        didSet {
            setupLabels(titleAppearsValue)
        }
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleAppear.isHidden = true
        yearAppear.isHidden = true
    }
    
    func setupLabels(_ value: String) {
        titleAppear = UILabel()
        titleAppear.text = value
        titleAppear.numberOfLines = 0
        titleAppear.font = UIFont(name: "RobotoCondensed-Regular", size: 16)
        self.addSubview(titleAppear!)
        
        
        yearAppear = UILabel()
        yearAppear.text = value
        yearAppear.numberOfLines = 0
        yearAppear.font = UIFont(name: "RobotoCondensed-Regular", size: 14)
        yearAppear.textColor = .gray
        self.addSubview(yearAppear!)
        
        setuptitleAppearsConstraints()
    }
    
    func setuptitleAppearsConstraints(){
        titleAppear.translatesAutoresizingMaskIntoConstraints = false
        titleAppear.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        titleAppear.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        yearAppear.translatesAutoresizingMaskIntoConstraints = false
        yearAppear.topAnchor.constraint(equalTo: titleAppear.bottomAnchor, constant: 10).isActive = true
        yearAppear.leadingAnchor.constraint(equalTo: titleAppear.leadingAnchor).isActive = true
    }
}
