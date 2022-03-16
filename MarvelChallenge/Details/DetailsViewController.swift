//
//  DetailsViewController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 07/03/2022.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var infoItem: Results!
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
        
        let nibCharacter = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        collectionScreen.register(nibCharacter, forCellWithReuseIdentifier: "ListCollectionViewCell")
        
        self.collectionScreen.delegate = self
        self.collectionScreen.dataSource = self
        
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionScreen.translatesAutoresizingMaskIntoConstraints = false
        collectionScreen.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        collectionScreen.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionScreen.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionScreen.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    func checkOrigin() {
        setAppears = infoItem.comics?.items ?? []
        if isCharacter == true {
            setSections.append("Image")
            if infoItem.resultDescription != "" {
                setSections.append("Description")
            }
            setSections.append("Title")
        } else {
            setSections.append("CellEvents")
            setSections.append("Title")
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
                cell.character = self.infoItem
                return cell
                
            case "CellEvents":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
                
                cell.listTitle.text = infoItem.title
                cell.lisDescription.text = infoItem.resultDescription
                let pathImage = (infoItem.thumbnail?.path)! + "." + (infoItem.thumbnail?.thumbnailExtension)!
                cell.listImage.pin_setImage(from: URL(string: pathImage)!)
                cell.imageEventMode()
                return cell
                
            case "Description":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellDescription", for: indexPath) as! DescriptionCollectionViewCell
                cell.character = self.infoItem
                return cell
                
            case "Title":
                let cell = collectionScreen.dequeueReusableCell(withReuseIdentifier: "cellTitle", for: indexPath) as! TitleCollectionViewCell
                if self.isCharacter {
                    cell.titleValue = "APPEARS IN THESE COMICS"
                } else {
                    cell.titleValue = "COMICS TO DISCUSS"
                }
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
                
            case "CellEvents":
                return CGSize(width: 344, height: 120 )
                
            case "Description":
                return CGSize(width: view.frame.width, height: 43 )
                
            case "Title":
                return CGSize(width: view.frame.width, height: 83 )
            default:
                return CGSize(width: 0, height: 0)
            }
        } else {
            return CGSize(width: view.frame.width, height: 88 )
        }
    }
}
