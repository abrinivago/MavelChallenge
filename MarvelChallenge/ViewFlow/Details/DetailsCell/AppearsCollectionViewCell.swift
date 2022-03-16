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
    var separator: UIView!
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
        
        separator = UIView()
        separator.backgroundColor = UIColor(hexConvert: "#E3E3E3")
        self.addSubview(separator)
        
        setuptitleAppearsConstraints()
    }
    
    func setuptitleAppearsConstraints(){
        titleAppear.translatesAutoresizingMaskIntoConstraints = false
        titleAppear.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        titleAppear.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        
        yearAppear.translatesAutoresizingMaskIntoConstraints = false
        yearAppear.topAnchor.constraint(equalTo: titleAppear.bottomAnchor, constant: 10).isActive = true
        yearAppear.leadingAnchor.constraint(equalTo: titleAppear.leadingAnchor).isActive = true
        
        separator.translatesAutoresizingMaskIntoConstraints = false
        separator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        separator.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        separator.widthAnchor.constraint(equalToConstant: self.frame.width - 32).isActive = true

    }
}
