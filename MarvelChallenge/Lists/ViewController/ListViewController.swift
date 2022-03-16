//
//  ListViewController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 06/03/2022.
//

import UIKit
import PINRemoteImage

class ListViewController: ListCustomClass {
    
    var modalDetails: DetailsViewController?
    var listViewModel = ListViewModel()
    var isCharacter: Bool!
    var listArray = [Results]()
    var ListCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinds()
        self.setupListCollection()
        self.checkOrigin()
        self.view.backgroundColor = .white
    }
    
    @objc func dismisModal(){
        self.ListCollectionView.backgroundColor = UIColor(hexConvert: "#ECEFF1")
        for recognizer in self.navigationController?.navigationBar.gestureRecognizers ?? [] {
            self.navigationController?.navigationBar.removeGestureRecognizer(recognizer)
        }
        UIView.transition(with: self.view, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.modalDetails?.view.removeFromSuperview()
        }, completion: {_ in
            self.modalDetails?.willMove(toParent: nil)
            self.modalDetails?.removeFromParent()
            self.tabBarController?.tabBar.isHidden.toggle()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavBar(title: "Marvel Challenge")
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
        
        ListCollectionView.backgroundColor = UIColor(hexConvert: "#ECEFF1")
        
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
                cell?.listTitle.text? = titleName.uppercased()
            } else {
                titleName = listArray[indexPath.row].title ?? ""
                cell?.imageEventMode()
                cell?.listTitle.text? = titleName
            }

            cell?.lisDescription.text = listArray[indexPath.row].resultDescription
            let pathImage = (listArray[indexPath.row].thumbnail?.path)! + "." + (listArray[indexPath.row].thumbnail?.thumbnailExtension)!
            cell?.listImage.image?.withAlignmentRectInsets(UIEdgeInsets(top: -17, left: -17, bottom: -17, right: -17))
            cell?.listImage.pin_setImage(from: URL(string: pathImage)!)
            
            return cell ?? ListCollectionViewCell()
        default:
            return ListCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.modalDetails(selectData: listArray[indexPath.row])
    }
    
    func modalDetails(selectData: Results){
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismisModal))
        self.navigationController?.navigationBar.addGestureRecognizer(tap)
        ListCollectionView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        modalDetails = DetailsViewController()
        modalDetails?.isCharacter = isCharacter
        modalDetails?.infoItem = selectData
        modalDetails?.view.frame = CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height)
        addChild(modalDetails ?? DetailsViewController())
        UIView.transition(with: self.view, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.view.addSubview(self.modalDetails?.view ?? UIView())
        }, completion: nil)
        
        modalDetails?.didMove(toParent: self)
        tabBarController?.tabBar.isHidden.toggle()
    }
    

}
