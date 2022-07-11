//
//  ViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit
import Charts

class FirstViewController: UIViewController {
    
    let viewChart = UIView()
    let expensesChart = PieChartView()
    let expensesTable = UITableView()

    let values: [Double] = [10,10,10,10,10,10,10,10,10,10,10]
    let colors: [UIColor] = [UIColor(named: "red")!, UIColor(named: "orange")!, UIColor(named: "yellow")!, UIColor(named: "mellon")!, UIColor(named: "salad")!, UIColor(named: "azure")!, UIColor(named: "blue")!, UIColor(named: "berry")!, UIColor(named: "purple")!, .systemGray3, UIColor(named: "corall")!]
    
    let totalExpensesString = "120,000 тг"
    let bonusString = "1,578 бонусов"
    let expenseCategories = ["Кафе и рестораны", "Такси", "Одежда и обувь", "Медицинские услуги", "Фитнес и SPA", "Салоны красоты и косметики"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        makeConstraints()
        configureChart()
        expensesTable.dataSource = self
        expensesTable.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    func configureChart() {
        var dataEntries: [PieChartDataEntry] = []
        
        for index in 0..<values.count {
            let entry = PieChartDataEntry(value: values[index])
            dataEntries.append(entry)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        pieChartDataSet.colors = colors
        
        expensesChart.data = PieChartData(dataSet: pieChartDataSet)
        
        let expensesAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20) ]
        expensesChart.centerAttributedText = NSAttributedString(string: totalExpensesString, attributes: expensesAttribute)
        expensesChart.legend.enabled = false
    }
    
    func makeConstraints() {
        view.addSubview(viewChart)
        viewChart.translatesAutoresizingMaskIntoConstraints = false
        viewChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        viewChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        viewChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        viewChart.heightAnchor.constraint(equalToConstant: 350).isActive = true
        viewChart.backgroundColor = .white
        viewChart.layer.cornerRadius = 50
        
        viewChart.addSubview(expensesChart)
        expensesChart.translatesAutoresizingMaskIntoConstraints = false
        expensesChart.topAnchor.constraint(equalTo: viewChart.topAnchor).isActive = true
        expensesChart.leadingAnchor.constraint(equalTo: viewChart.leadingAnchor).isActive = true
        expensesChart.trailingAnchor.constraint(equalTo: viewChart.trailingAnchor).isActive = true
        expensesChart.heightAnchor.constraint(equalToConstant: 350).isActive = true

        view.addSubview(expensesTable)
        expensesTable.translatesAutoresizingMaskIntoConstraints = false
        expensesTable.topAnchor.constraint(equalTo: viewChart.bottomAnchor, constant: 16).isActive = true
        expensesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        expensesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        expensesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        expensesTable.layer.cornerRadius = 30
    }
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        expenseCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.assignParameters(expenseCategories[indexPath.row])
        
        return cell
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
