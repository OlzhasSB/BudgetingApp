//
//  ViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit
import Charts

class FirstViewController: UIViewController {
    
    let pieChartView = PieChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        makeConstraints()
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun"]
        let unitsSold: [Double] = [10, 15, 20, 40, 5, 10]
        setChart(dataPoints: months, values: unitsSold)
    }
    
    func setChart(dataPoints: [String], values: [Double]) {
        
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let a = PieChartDataEntry(value: values[i])
            dataEntries.append(a)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "[Units Sold]")
        
        let colors: [UIColor] = [.systemOrange, .systemBlue, .systemCyan, .systemGreen, .systemYellow, .systemPink]

        pieChartDataSet.colors = colors
        
        pieChartView.data = PieChartData(dataSet: pieChartDataSet)
        pieChartView.centerText = "Hello"
        pieChartView.drawEntryLabelsEnabled = false
    }
    
    func makeConstraints() {
        view.addSubview(pieChartView)
        pieChartView.translatesAutoresizingMaskIntoConstraints = false
        pieChartView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pieChartView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pieChartView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pieChartView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
}
