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
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    func setControllers() {
        let vc1 = ListViewController()
        vc1.isCharacter = true
        let icon1 = UIImage(named: "icon-superhero-disabled")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let icon1Selected = UIImage(named: "icon-superhero")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc1.tabBarItem = UITabBarItem(title: "Characters",
                                      image: icon1,
                                      selectedImage: icon1Selected)
        
        let vc2 = ListViewController()
        vc2.isCharacter = false
        let icon2 = UIImage(named: "icon-calendar-disabled")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        let icon2Selected = UIImage(named: "icon-calendar")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        vc2.tabBarItem = UITabBarItem(title: "Events",
                                      image: icon2,
                                      selectedImage: icon2Selected)
        
        self.setViewControllers([vc1, vc2], animated: true)
    }
}
