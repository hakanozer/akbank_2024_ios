//
//  AppTabBarController.swift
//  2-Days
//
//  Created by HAKAN ÖZER on 27.02.2024.
//

import UIKit

class AppTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers?[0].tabBarItem.badgeValue = "3"
        selectedIndex = 1
        print("AppTabBarController Call")
        
        let width = self.tabBar.bounds.width
        let height = self.view.bounds.height
        let tabHeight = self.tabBar.bounds.height
        let box = UIView(frame: CGRect(x: (width - 60), y: (height - (tabHeight + 95)), width: 50, height: 50))
        
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        btn.setTitle("Add", for: .normal)
        btn.backgroundColor = UIColor.darkGray
        btn.addTarget(self, action: #selector(fncAdd), for: .touchUpInside)
        
        box.addSubview(btn)
        self.view.addSubview(box)
    }
    
    @objc func fncAdd() {
        selectedIndex = 2
    }


}
