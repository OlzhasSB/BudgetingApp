//
//  CategoryCell.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 11.07.2022.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let image = UIImageView()
//    let numberOfTransactionsLabel = UILabel()
    let expensesLabel = UILabel()
    let bonusLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignParameters(_ name: String) {
        nameLabel.text = name
    }
    
    func makeConstraints() {
        contentView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        let config = UIImage.SymbolConfiguration(pointSize: 28)
        image.image = UIImage(systemName: "bag.fill", withConfiguration: config)
        
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16).isActive = true
        
        contentView.addSubview(expensesLabel)
        expensesLabel.translatesAutoresizingMaskIntoConstraints = false
        expensesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        expensesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        expensesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        expensesLabel.text = "90,000 тг"
    }

}
