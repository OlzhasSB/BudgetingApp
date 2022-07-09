//
//  MyBankScrollView.swift
//  BudgetingApp
//
//  Created by Aidyn Assan on 08.07.2022.
//

import UIKit

class MyBankScrollView: UIScrollView {
	
	let view = UIView()

	let bonusView: InfoView = {
		let infoView = InfoView()
		infoView.infoImageView.image = UIImage(named: "bonus")
		infoView.topLabel.text = "Бонусы 2 %"
		infoView.midLabel.text = "3890 Б"
		infoView.bottomLabel.text = "Максимальный уровень\n ...................................................................."
		return infoView
	}()
	
	let sectionTitleLabel: UILabel = {
		let label = UILabel()
		label.text = "Карты"
		label.textColor = .systemGray
		label.font = .boldSystemFont(ofSize: 24)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let cardView: InfoView = {
		let infoView = InfoView()
		infoView.infoImageView.image = UIImage(named: "card")
		infoView.topLabel.text = "Платежная карта •3333"
		infoView.midLabel.text = "573890 ₸"
		infoView.bottomLabel.text = "в блоке 750 ₸"
		return infoView
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		view.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(bonusView)
		NSLayoutConstraint.activate([
			bonusView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
			bonusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			bonusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			bonusView.heightAnchor.constraint(equalToConstant: 100)
		])
		
		view.addSubview(sectionTitleLabel)
		NSLayoutConstraint.activate([
			sectionTitleLabel.topAnchor.constraint(equalTo: bonusView.bottomAnchor, constant: 20),
			sectionTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
			sectionTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			sectionTitleLabel.heightAnchor.constraint(equalToConstant: 40)
		])

		view.addSubview(cardView)
		NSLayoutConstraint.activate([
			cardView.topAnchor.constraint(equalTo: sectionTitleLabel.bottomAnchor, constant: 20),
			cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
			cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
			cardView.heightAnchor.constraint(equalToConstant: 100)
		])
		
		addSubview(view)
	}
}
