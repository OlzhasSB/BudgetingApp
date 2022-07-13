//
//  ViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit
import Charts

class FirstViewController: UIViewController {
    
    private let backgroundViewForChart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 50
        return view
    }()
    private let expensesChart: PieChartView = {
        let chart = PieChartView()
        chart.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuad)
        return chart
    }()
    private let expensesTable: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 30
        table.showsVerticalScrollIndicator = false
        return table
    }()

    var categories: [Category] = [
        Category(name: "Фитнес и SPA", imageName: "figure.walk", expense: 0, bonus: 0, color: UIColor(named: "red")!),
        Category(name: "Такси", imageName: "car.circle.fill", expense: 2, bonus: 0, color: UIColor(named: "orange")!),
        Category(name: "Салоны красоты и косметики", imageName: "sparkles", expense: 3, bonus: 0, color: UIColor(named: "yellow")!),
        Category(name: "Кафе и рестораны", imageName: "fork.knife.circle.fill", expense: 4, bonus: 0, color: UIColor(named: "mellon")!),
        Category(name: "Медицинские услуги", imageName: "pills.circle.fill", expense: 10, bonus: 0, color: UIColor(named: "salad")!),
        Category(name: "Онлайн кино и музыка", imageName: "music.note.tv.fill", expense: 5, bonus: 0, color: UIColor(named: "azure")!),
        Category(name: "Одежда и обувь", imageName: "bag.fill", expense: 9, bonus: 0, color: UIColor(named: "blue")!),
        Category(name: "Игровые сервисы", imageName: "gamecontroller.fill", expense: 6, bonus: 0, color: UIColor(named: "berry")!),
        Category(name: "Путешествия", imageName: "airplane.circle.fill",
                 expense: 1, bonus: 0, color: UIColor(named: "purple")!),
        Category(name: "Мебель", imageName: "bed.double.circle.fill", expense: 4, bonus: 0, color: UIColor(named: "corall")!),
        Category(name: "Другое", imageName: "rays", expense: 3, bonus: 0, color: .systemGray3)
    ]
    let totalExpensesString = "120,000 тг"
    let bonusString = "1,578 бонусов"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        
        makeConstraints()
        sortByDecreaseExpenses()
        
        configureChart()
        configureTable()
    }
    
    private func sortByDecreaseExpenses() {
        categories = categories.sorted(by: { $0.expense > $1.expense })
    }
    
    private func configureTable() {
        expensesTable.dataSource = self
        expensesTable.delegate = self
        expensesTable.register(CategoryCell.self, forCellReuseIdentifier: "categoryCell")
    }
    
    private func configureChart() {
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
    
    private func makeConstraints() {
        view.addSubview(backgroundViewForChart)
        backgroundViewForChart.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForChart.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundViewForChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backgroundViewForChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        backgroundViewForChart.heightAnchor.constraint(equalToConstant: 350).isActive = true
        
        backgroundViewForChart.addSubview(expensesChart)
        expensesChart.translatesAutoresizingMaskIntoConstraints = false
        expensesChart.topAnchor.constraint(equalTo: backgroundViewForChart.topAnchor).isActive = true
        expensesChart.leadingAnchor.constraint(equalTo: backgroundViewForChart.leadingAnchor).isActive = true
        expensesChart.trailingAnchor.constraint(equalTo: backgroundViewForChart.trailingAnchor).isActive = true
        expensesChart.heightAnchor.constraint(equalToConstant: 350).isActive = true

        view.addSubview(expensesTable)
        expensesTable.translatesAutoresizingMaskIntoConstraints = false
        expensesTable.topAnchor.constraint(equalTo: backgroundViewForChart.bottomAnchor, constant: 16).isActive = true
        expensesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        expensesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        expensesTable.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16).isActive = true
    }
    
}
// MARK: - TableView Delegates
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

// MARK: - CharView Delegate
extension FirstViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        let index = Int(highlight.x)
        expensesTable.selectRow(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .middle)
    }
}
