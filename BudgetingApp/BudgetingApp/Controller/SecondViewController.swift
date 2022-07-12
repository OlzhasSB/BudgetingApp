//
//  SecondViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 09.07.2022.
//

import UIKit
import Charts

class SecondViewController: UIViewController {

    private let historyChart = BarChartView()
    private let backgroundViewForChart = UIView()
    private let forecastedExpensesTable = UITableView()
    private let button = UIButton()
    
//    let data = [
//        [5,5],
//        [4,4]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        makeConstraints()
        
    }
    
    @objc private func addButtonPressed() {
        print("Works!")
    }
    
    
    private func makeConstraints() {
        view.addSubview(backgroundViewForChart)
        backgroundViewForChart.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundViewForChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backgroundViewForChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        backgroundViewForChart.heightAnchor.constraint(equalToConstant: 350).isActive = true
        backgroundViewForChart.backgroundColor = .white
        backgroundViewForChart.layer.cornerRadius = 50
        
        backgroundViewForChart.addSubview(historyChart)
        historyChart.translatesAutoresizingMaskIntoConstraints = false
        historyChart.topAnchor.constraint(equalTo: backgroundViewForChart.topAnchor).isActive = true
        historyChart.leadingAnchor.constraint(equalTo: backgroundViewForChart.leadingAnchor).isActive = true
        historyChart.trailingAnchor.constraint(equalTo: backgroundViewForChart.trailingAnchor).isActive = true
        historyChart.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        view.addSubview(forecastedExpensesTable)
        forecastedExpensesTable.translatesAutoresizingMaskIntoConstraints = false
        forecastedExpensesTable.topAnchor.constraint(equalTo: backgroundViewForChart.bottomAnchor, constant: 16).isActive = true
        forecastedExpensesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        forecastedExpensesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        forecastedExpensesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        forecastedExpensesTable.layer.cornerRadius = 30
        forecastedExpensesTable.showsVerticalScrollIndicator = false
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: forecastedExpensesTable.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: forecastedExpensesTable.bottomAnchor, constant: -16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        button.layer.cornerRadius = 25
        button.setImage(UIImage(named: "add"), for: .normal)
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
    }
    
}
