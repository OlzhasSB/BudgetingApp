//
//  MyBankViewController.swift
//  BudgetingApp
//
//  Created by Aidyn Assan on 08.07.2022.
//

import UIKit

class MyBankViewController: UIViewController {
    
    private var networkManager = NetworkManager.shared
    let username = "test"
    let password = "test"
    
    let button = UIButton()
	let scrollView = MyBankScrollView()
    
	override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .systemBackground
		configureNC()
		configure()
        
        networkManager.auth(username: username, password: password)
	}

	func configureNC() {
		let personImage = UIImage(systemName: "person.circle.fill")
		let button = UIBarButtonItem(image: personImage,
									 style: .plain,
									 target: nil, action: #selector(doNothing))
		let bellImage = UIImage(systemName: "bell")
		let buttonN = UIBarButtonItem(image: bellImage,
									  style: .plain,
									  target: nil, action: #selector(doNothing))
		let searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 270, height: 20))
		searchBar.placeholder = "Поиск в Jusan"
		let leftNavBarButton = UIBarButtonItem(customView:searchBar)
		UINavigationBar.appearance().tintColor = .systemGray
		navigationItem.rightBarButtonItems = [button, buttonN]
		navigationItem.leftBarButtonItem = leftNavBarButton
	}
	
    @objc func doNothing() {}
    
	func configure() {
		view.addSubview(scrollView)
		scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height-70)
		NSLayoutConstraint.activate([
			scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
    
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.addTarget(self, action: #selector(pressed), for: .touchUpInside)
        button.backgroundColor = .red
        
	}
    
    @objc func pressed() {
        let vc = TabBarViewController()
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
