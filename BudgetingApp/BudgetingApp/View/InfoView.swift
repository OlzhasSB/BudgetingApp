//
//  InfoView.swift
//  BudgetingApp
//
//  Created by Aidyn Assan on 08.07.2022.
//

import UIKit

class InfoView: UIView {
	
	let infoImageView: UIImageView = {
		let imageView = UIImageView()
		imageView.layer.cornerRadius = 10
		imageView.translatesAutoresizingMaskIntoConstraints = false
		return imageView
	}()
	
	let topLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 18)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let midLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 20)
		
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	let bottomLabel: UILabel = {
		let label = UILabel()
		label.font = .systemFont(ofSize: 14)
		label.textColor = .systemGray2
		label.numberOfLines = 2
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()
	
	override init(frame: CGRect) {
		super .init(frame: frame)
		translatesAutoresizingMaskIntoConstraints = false
		configure()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func configure() {
		let padding: CGFloat = 3
		addSubview(infoImageView)
		NSLayoutConstraint.activate([
			infoImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
			infoImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
			infoImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			infoImageView.widthAnchor.constraint(equalTo: infoImageView.heightAnchor)
		])
		
		addSubview(topLabel)
		NSLayoutConstraint.activate([
			topLabel.topAnchor.constraint(equalTo: infoImageView.topAnchor, constant: 3),
			topLabel.leadingAnchor.constraint(equalTo: infoImageView.trailingAnchor, constant: padding+10),
			topLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding)
		])
		
		addSubview(bottomLabel)
		NSLayoutConstraint.activate([
			bottomLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
			bottomLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
			bottomLabel.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor)
		])
		
		addSubview(midLabel)
		NSLayoutConstraint.activate([
			midLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: padding),
			midLabel.leadingAnchor.constraint(equalTo: topLabel.leadingAnchor),
			midLabel.trailingAnchor.constraint(equalTo: topLabel.trailingAnchor),
			midLabel.bottomAnchor.constraint(equalTo: bottomLabel.topAnchor, constant: -padding)
		])
	}
}
