//
//  DetailsViewController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 07/03/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var character: Results!
    var collectionScreen: UICollectionView!
    var collectionList: UICollectionView!
    var isCharacter: Bool!
    var setSections: [String] = []
    var setAppears: [Next] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollection()
        checkOrigin()
    }
    
    func setupCollection() {
        let collectionFlow = UICollectionViewFlowLayout()
        collectionFlow.scrollDirection = .vertical
        collectionScreen = UICollectionView(frame: .zero, collectionViewLayout: collectionFlow)
        view.addSubview(collectionScreen)
        self.collectionScreen.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "cellImage")
        self.collectionScreen.register(DescriptionCollectionViewCell.self, forCellWithReuseIdentifier: "cellDescription")
        self.collectionScreen.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: "cellTitle")
        self.collectionScreen.register(AppearsCollectionViewCell.self, forCellWithReuseIdentifier: "cellAppears")
        
        self.collectionScreen.delegate = self
        self.collectionScreen.dataSource = self
        
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionScreen.translatesAutoresizingMaskIntoConstraints = false
        collectionScreen.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        collectionScreen.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        collectionScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func checkOrigin() {
        if isCharacter == true {
            setSections.append("Image")
            if character.resultDescription != "" {
                setSections.append("Description")
            }
            setSections.append("CharacterTitle")
            setAppears = character.comics?.items ?? []
        } else {
            print("Events")
        }
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = setSections.count + setAppears.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row <= (setSections.count - 1) {
            switch setSections[indexPath.row] {
            case "Image":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellImage", for: indexPath) as! ImageCollectionViewCell
                cell.character = self.character
                return cell
                
            case "Description":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellDescription", for: indexPath) as! DescriptionCollectionViewCell
                cell.character = self.character
                return cell
                
            case "CharacterTitle":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellTitle", for: indexPath) as! TitleCollectionViewCell
                cell.titleValue = "COMICS EN LOS QUE APARECE"
                return cell
            default:
                return UICollectionViewCell()
            }
        } else {
            let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellAppears", for: indexPath) as! AppearsCollectionViewCell
            cell.titleAppearsValue = setAppears[indexPath.row - setSections.count].name
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row <= (setSections.count - 1) {
            switch setSections[indexPath.row] {
            case "Image":
                return CGSize(width: view.frame.width, height: view.frame.width)
                
            case "Description":
                return CGSize(width: view.frame.width, height: 43 )
                
            case "CharacterTitle":
                return CGSize(width: view.frame.width, height: 83 )
            default:
                return CGSize(width: 0, height: 0)
            }
        } else {
            return CGSize(width: view.frame.width, height: 88 )
        }
    }
}
