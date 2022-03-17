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
    let spinner = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBinds()
        self.setupListCollection()
        self.checkOrigin()
        tabBarController?.navigationItem.hidesBackButton = true
        self.setupRightButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setupNavBar()
    }
    
    func checkOrigin(_ pagination: String = "0") {
        if isCharacter {
            self.listViewModel.getCharacter(pagination)
        } else {
            self.listViewModel.getEvents(pagination)
        }
    }
    
    func setupLeftButton() {
        let closeCharacterModal = UIButton(type: .system)
        closeCharacterModal.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeCharacterModal.tintColor = .white
        closeCharacterModal.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: closeCharacterModal)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismisModal))
        closeCharacterModal.addGestureRecognizer(tapGesture)
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
        let nibListCell = UINib(nibName: "ListCollectionViewCell", bundle: nil)
        ListCollectionView.register(nibListCell, forCellWithReuseIdentifier: "ListCollectionViewCell")
    }
    
    func setBinds() {
        self.listViewModel.bindStartRequest = {() -> Void in
            print("Start Request")
        }
        self.listViewModel.bindRequestData = {(_ arrayList: [Results]?) -> Void in
            self.listArray.append(contentsOf: arrayList ?? [])
            self.ListCollectionView.reloadData()
        }
        self.listViewModel.bindErrorMessage = {(_ errorMessage: String) -> Void in
            print(errorMessage)
        }
        self.listViewModel.bindEndRequest = {() -> Void in
            print("End Request")
        }
    }
}

extension ListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let currentCount = self.listArray.count
        if indexPath.row == (currentCount - 3) && ((listViewModel.totalCount ?? 0) - 3 ) > currentCount - 3 {
            self.checkOrigin(String(currentCount))
        }
        
        let cell = ListCollectionViewCell.buildCellInCollection(collectionView, cellForItemAt: indexPath, resultData: listArray[indexPath.row], isCharacter: isCharacter)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.modalDetails(selectData: listArray[indexPath.row])
    }
    
    func modalDetails(selectData: Results){
        self.ListCollectionView.isHidden.toggle()
        tabBarController?.navigationItem.rightBarButtonItem = nil
        modalDetails = DetailsViewController()
        modalDetails?.isCharacter = isCharacter
        modalDetails?.infoItem = selectData
        
        var contentFrame: CGRect = .zero
        var transition: UIView.AnimationOptions = .transitionCrossDissolve
        
        if isCharacter {
            self.setupNavBar(title: (selectData.name)?.uppercased() ?? "")
            self.setupLeftButton()
            contentFrame = CGRect(x: 0, y: 90, width: view.frame.width, height: view.frame.height)
        } else {
            contentFrame = CGRect(x: 8, y: 100, width: view.frame.width - 16, height: view.frame.height)
            let tap = UITapGestureRecognizer(target: self, action: #selector(dismisModal))
            self.navigationController?.navigationBar.addGestureRecognizer(tap)
            let label = tabBarController?.navigationItem.titleView?.subviews[0] as? UILabel
            label?.textColor = .lightText
            transition = .transitionFlipFromLeft
        }
        
        modalDetails?.view.frame = contentFrame
        addChild(modalDetails ?? DetailsViewController())
        tabBarController?.tabBar.isHidden.toggle()
        UIView.transition(with: self.view, duration: 0.3, options: [transition], animations: {
            self.view.addSubview(self.modalDetails?.view ?? UIView())
        }, completion: nil)
        modalDetails?.didMove(toParent: self)
    }
    
    @objc func dismisModal(){
        self.setupNavBar()
        self.setupRightButton()
        self.ListCollectionView.isHidden.toggle()
        tabBarController?.navigationItem.leftBarButtonItem = nil
        let label = tabBarController?.navigationItem.titleView?.subviews[0] as? UILabel
        label?.textColor = .white
        for recognizer in self.navigationController?.navigationBar.gestureRecognizers ?? [] {
            self.navigationController?.navigationBar.removeGestureRecognizer(recognizer)
        }
        self.tabBarController?.tabBar.isHidden.toggle()
        UIView.transition(with: self.view, duration: 0.3, options: [.transitionCrossDissolve], animations: {
            self.modalDetails?.view.removeFromSuperview()
        }, completion: {_ in
            self.modalDetails?.willMove(toParent: nil)
            self.modalDetails?.removeFromParent()
        })
    }
}
