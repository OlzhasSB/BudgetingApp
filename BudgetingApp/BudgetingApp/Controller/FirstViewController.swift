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

    var categories: [Category] = [
        Category(name: "Фитнес и SPA", imageName: "dumbbell.fill", expense: 0, bonus: 0, color: UIColor(named: "red")!),
        Category(name: "Такси", imageName: "car.circle.fill", expense: 2, bonus: 0, color: UIColor(named: "orange")!),
        Category(name: "Салоны красоты и косметики", imageName: "sparkles", expense: 3, bonus: 0, color: UIColor(named: "yellow")!),
        Category(name: "Кафе и рестораны", imageName: "fork.knife.circle.fill", expense: 4, bonus: 0, color: UIColor(named: "mellon")!),
        Category(name: "Медицинские услуги", imageName: "pills.circle.fill", expense: 10, bonus: 0, color: UIColor(named: "salad")!),
        Category(name: "Онлайн кино и музыка", imageName: "music.note.tv.fill", expense: 5, bonus: 0, color: UIColor(named: "azure")!),
        Category(name: "Одежда и обувь", imageName: "bag.fill", expense: 9, bonus: 0, color: UIColor(named: "blue")!),
        Category(name: "Игровые сервисы", imageName: "gamecontroller.fill", expense: 6, bonus: 0, color: UIColor(named: "berry")!),
        Category(name: "Путешествия", imageName: "airplane.circle.fill",
                 expense: 1, bonus: 0, color: UIColor(named: "purple")!),
        Category(name: "Мебель", imageName: "chair.lounge.fill", expense: 4, bonus: 0, color: UIColor(named: "corall")!),
        Category(name: "Другое", imageName: "rays", expense: 3, bonus: 0, color: .systemGray3)

    ]
    
    let totalExpensesString = "120,000 тг"
    let bonusString = "1,578 бонусов"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        makeConstraints()
        loadCategories()
        sortByExpense()
        configureChart()
        expensesTable.dataSource = self
        expensesTable.delegate = self
        expensesTable.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    func sortByExpense() {
        categories = categories.sorted(by: { $0.expense > $1.expense })
    }
    
    func loadCategories() {
        
    }
    
    func configureChart() {
        var dataEntries: [PieChartDataEntry] = []
        var colors: [UIColor] = []
        
        for index in 0..<categories.count {
            let entry = PieChartDataEntry(value: categories[index].expense)
            dataEntries.append(entry)
            colors.append(categories[index].color)
        }
        
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        pieChartDataSet.colors = colors
        pieChartDataSet.drawValuesEnabled = false
        
        expensesChart.data = PieChartData(dataSet: pieChartDataSet)
        
        let expensesAttribute = [ NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20) ]
        expensesChart.centerAttributedText = NSAttributedString(string: totalExpensesString, attributes: expensesAttribute)
        
        expensesChart.legend.enabled = false
        expensesChart.delegate = self
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
        expensesChart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuad)

        view.addSubview(expensesTable)
        expensesTable.translatesAutoresizingMaskIntoConstraints = false
        expensesTable.topAnchor.constraint(equalTo: viewChart.bottomAnchor, constant: 16).isActive = true
        expensesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        expensesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        expensesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
        expensesTable.layer.cornerRadius = 30
        expensesTable.showsVerticalScrollIndicator = false
    }
    
}

extension FirstViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! CategoryCell
        cell.assignParameters(categories[indexPath.row])
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.systemGray5
        cell.selectedBackgroundView = backgroundView
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        expensesChart.highlightValue(Highlight(x: Double(indexPath.row), dataSetIndex: 0, stackIndex: 0))
    }
}

extension FirstViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = Int(highlight.x)
        expensesTable.selectRow(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .middle)
    }
}
