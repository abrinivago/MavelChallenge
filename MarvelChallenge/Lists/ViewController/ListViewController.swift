//
//  ListViewController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import UIKit
import PINRemoteImage

class ListViewController: UIViewController {
    
    var listViewModel = ListViewModel()
    var isCharacter: Bool!
    var listArray = [Results]()
    var ListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinds()
        self.setupListCollection()
        self.checkOrigin()
        view.backgroundColor = .white
    }
    
    func checkOrigin(_ pagination: String = "0") {
        if isCharacter == true {
            self.listViewModel.getCharacter(pagination)
        } else {
            self.listViewModel.getEvents(pagination)
        }
    }
    
    func setupListCollection() {
        
        let ListCollectionFlow = UICollectionViewFlowLayout()
        ListCollectionFlow.itemSize = CGSize(width: view.frame.width - 16, height: 120)
        ListCollectionFlow.scrollDirection = .vertical
        ListCollectionFlow.sectionInset.top = 9
        ListCollectionFlow.sectionInset.bottom = 9
        
        ListCollectionView = UICollectionView(frame: .zero, collectionViewLayout: ListCollectionFlow)
        
        self.view.addSubview(ListCollectionView)
        ListCollectionView.translatesAutoresizingMaskIntoConstraints = false
        ListCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        ListCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        ListCollectionView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        ListCollectionView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor).isActive = true
        
        ListCollectionView.delegate = self
        ListCollectionView.dataSource = self
        
        let nibCharacter = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        ListCollectionView.register(nibCharacter, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
    func setBinds() {
        self.listViewModel.bindStartRequest = {() -> Void in
            print("Inicia la consulta")
        }
        
        self.listViewModel.bindRequestData = {(_ arrayList: [Results]?) -> Void in
            self.listArray.append(contentsOf: arrayList ?? [])
            self.ListCollectionView.reloadData()
        }
        
        self.listViewModel.bindErrorMessage = {(_ errorMessage: String) -> Void in
            print(errorMessage)
        }
        
        self.listViewModel.bindEndRequest = {() -> Void in
            print("Termina la consulta")
        }
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var numbersItems: Int = 0
        
        switch collectionView {
        case ListCollectionView:
            numbersItems = self.listArray.count
        default:
            print("Error")
        }
        return numbersItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case ListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as? ListCollectionViewCell
            
            let currentCount = self.listArray.count
            
            if indexPath.row == (currentCount - 3) {
                self.checkOrigin(String(currentCount))
                self.ListCollectionView.reloadData()
            }
            
            var titleName: String = ""
            
            if self.isCharacter {
                titleName = listArray[indexPath.row].name ?? ""
            } else {
                titleName = listArray[indexPath.row].title ?? ""
            }
            
            cell?.listTitle.text = titleName
            cell?.lisDescription.text = listArray[indexPath.row].resultDescription
            let pathImage = (listArray[indexPath.row].thumbnail?.path)! + "." + (listArray[indexPath.row].thumbnail?.thumbnailExtension)!
            cell?.listImage.pin_setImage(from: URL(string: pathImage)!)
            
            return cell ?? ListCollectionViewCell()
        default:
            return ListCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.isCharacter = true
        vc.character = listArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
