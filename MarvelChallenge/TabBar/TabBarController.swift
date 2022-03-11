//
//  TabBarController.swift
//  MarvelChallenge
//
//  Created by Antonella Brini Vago on 11/03/2022.
//

import Foundation
import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
    }
    
    func setControllers() {
        let vc1 = ListViewController()
        vc1.isCharacter = true
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")
        vc1.title = "Characters"
        
        let vc2 = ListViewController()
        vc2.isCharacter = false
        vc2.tabBarItem.image = UIImage(systemName: "note.text")
        vc2.title = "Events"
        
        self.setViewControllers([vc1, vc2], animated: true)
    }
}
