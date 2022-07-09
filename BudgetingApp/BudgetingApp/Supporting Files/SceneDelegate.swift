//
//  SceneDelegate.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
		window = UIWindow(windowScene: windowScene)
		window?.rootViewController = createTabBar()
		window?.makeKeyAndVisible()
    }
	
	func mainNC() -> UINavigationController {
		let mainVC = UIViewController()
		mainVC.view.backgroundColor = .systemBackground
		let image = UIImage(systemName: "house.fill")
		mainVC.tabBarItem = UITabBarItem(title: "главная", image: image, tag: 0)
		let navVC =  UINavigationController(rootViewController: mainVC)
		return navVC
	}
	
	func myBankNC() -> UINavigationController {
		let mybankVC = MyBankViewController()
		mybankVC.view.backgroundColor = .systemBackground
		let icon = UIImage(systemName: "creditcard.fill")
		mybankVC.tabBarItem = UITabBarItem(title: "мой банк", image: icon, tag: 1)
		return UINavigationController(rootViewController: mybankVC)
	}
	
	func transactionNC() -> UINavigationController {
		let mybankVC = UIViewController()
		mybankVC.view.backgroundColor = .systemBackground
		let image = UIImage(systemName: "arrow.left.arrow.right.square.fill")
		mybankVC.tabBarItem = UITabBarItem(title: "переводы", image: image, tag: 2)
		return UINavigationController(rootViewController: mybankVC)
	}
	
	func paymentNC() -> UINavigationController {
		let mybankVC = UIViewController()
		mybankVC.view.backgroundColor = .systemBackground
		let image = UIImage(systemName: "arrow.right.square.fill")
		mybankVC.tabBarItem = UITabBarItem(title: "платежи", image: image, tag: 3)
		return UINavigationController(rootViewController: mybankVC)
	}
	
	func menuNC() -> UINavigationController {
		let mybankVC = UIViewController()
		mybankVC.view.backgroundColor = .systemBackground
		let image = UIImage(systemName: "command.square.fill")
		mybankVC.tabBarItem = UITabBarItem(title: "меню", image: image, tag: 4)
		return UINavigationController(rootViewController: mybankVC)
	}
	
	func createTabBar() -> UITabBarController {
		let tabBar = UITabBarController()
		tabBar.viewControllers = [mainNC(), myBankNC(), transactionNC(), paymentNC(), menuNC()]
		UITabBar.appearance().tintColor = #colorLiteral(red: 0.9400814772, green: 0.3291375041, blue: 0.1390302777, alpha: 1)
		tabBar.tabBar.layer.borderWidth = 1.5
		tabBar.tabBar.layer.borderColor = UIColor.systemGray6.cgColor
		tabBar.tabBar.clipsToBounds = true
		return tabBar
	}

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

