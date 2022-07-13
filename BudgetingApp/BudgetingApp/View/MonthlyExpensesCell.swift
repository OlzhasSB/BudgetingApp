//
//  MonthlyExpensesCell.swift
//  BudgetingApp
//
//  Created by Olzhas on 12.07.2022.
//

import UIKit

class MonthlyExpensesCell: UITableViewCell {
    
    let image = UIImageView()
    let expensesLabel = UILabel()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        makeConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func assignParameters(_ category: Category) {
        nameLabel.text = category.name
        expensesLabel.text = "\(category.expense) тг"
        
        let config = UIImage.SymbolConfiguration(pointSize: 28)
        image.image = UIImage(systemName: category.imageName, withConfiguration: config)
        image.tintColor = category.color
    }
    
    private func makeConstraints() {
        contentView.addSubview(expensesLabel)
        expensesLabel.translatesAutoresizingMaskIntoConstraints = false
        expensesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        expensesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        expensesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        
        contentView.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        image.centerXAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28).isActive = true

        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 60).isActive = true
        nameLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
    }

}
