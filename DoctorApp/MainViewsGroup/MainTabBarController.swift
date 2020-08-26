//
//  MainTabBarController.swift
//  DoctorApp
//
//  Created by Ян Мелоян on 11.08.2020.
//  Copyright © 2020 mika. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        tabBar.isTranslucent = true
        
        tabBar.tintColor = .bgColor
        
        buildTabs()
        
        AuthService.main.me()
    }
    
    func buildTabs() {
        let vc = EventListViewController()
        vc.tabBarItem = .init(title: nil, image: .init(imageLiteralResourceName: "eventList"), tag: 1)
        vc.tabBarItem.imageInsets = .init(top: 6, left: 0, bottom: -6, right: 0)

        let vc2 = DoctorListViewController()
        vc2.tabBarItem = .init(title: nil, image: UIImage(imageLiteralResourceName: "doctorList"), tag: 0)
        vc2.tabBarItem.imageInsets = .init(top: 4, left: 0, bottom: -4, right: 0)

        viewControllers = [
            YoustersNavigationController(rootViewController: vc2),
            YoustersNavigationController(rootViewController: vc)
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
