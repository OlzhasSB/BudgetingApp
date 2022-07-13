//
//  TabBarViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 09.07.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    private var networkManager = NetworkManager.shared
    let username = "Olzhas"
    let password = "123"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    
        configureTabBarItems()
        
        networkManager.auth(username: username, password: password)
    }
    
    private func configureTabBarItems() {
        self.tabBar.layer.borderWidth = 1.5
        self.tabBar.layer.borderColor = UIColor.systemGray6.cgColor
        
        let vc1 = FirstViewController()
        let image1 = UIImage(systemName: "chart.pie")
        vc1.tabBarItem = UITabBarItem(title: "Аналитика", image: image1, tag: 2)
        
        let vc2 = SecondViewController()
        let image2 = UIImage(systemName: "chart.bar.xaxis")
        vc2.tabBarItem = UITabBarItem(title: "Прогноз", image: image2, tag: 2)
        
        let vc3 = ThirdViewController()
        let image3 = UIImage(systemName: "house")
        vc3.tabBarItem = UITabBarItem(title: "Домой", image: image3, tag: 2)
        self.setViewControllers([vc1, vc2, vc3], animated: false)
    }

}
