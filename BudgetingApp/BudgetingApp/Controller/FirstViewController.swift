//
//  ViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit
import Charts

class FirstViewController: UIViewController {
    
    private var networkManager = NetworkManager.shared
    
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

    var categories: [Category] = []
    let totalExpensesString = "120,000 тг"
    let bonusString = "1,578 бонусов"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        loadCategories()
        makeConstraints()
        configureTable()
    }

    private func loadCategories() {
        loadTravelCategory()
        loadTaxiCategory()
        loadRestaurantsCategory()
        loadOthersCategory()
        loadMedicineCategory()
        loadGamesCategory()
        loadFurnitureCategory()
        loadFitnessCategory()
        loadClothesCategory()
        loadCinemaMusicCategory()
        loadBeautyCategory()
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

// MARK: - Network requests
extension FirstViewController {
    func loadTravelCategory() {
        networkManager.getPurchases(path: "/travel") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Путешествия", imageName: "airplane.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "purple")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadTaxiCategory() {
        networkManager.getPurchases(path: "/taxi") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Такси", imageName: "car.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "orange")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadRestaurantsCategory() {
        networkManager.getPurchases(path: "/restaurants") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Кафе и рестораны", imageName: "fork.knife.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "mellon")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadOthersCategory() {
        networkManager.getPurchases(path: "/no-category") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Другое", imageName: "rays", expense: purchases.expenditure, bonus: purchases.bonus, color: .systemGray3)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadMedicineCategory() {
        networkManager.getPurchases(path: "/medicine") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Медицинские услуги", imageName: "pills.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "salad")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadGamesCategory() {
        networkManager.getPurchases(path: "/games") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Игровые сервисы", imageName: "gamecontroller.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "berry")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadFurnitureCategory() {
        networkManager.getPurchases(path: "/furniture") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Мебель", imageName: "bed.double.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "corall")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadFitnessCategory() {
        networkManager.getPurchases(path: "/fitness") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Фитнес и SPA", imageName: "figure.walk", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "red")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadClothesCategory() {
        networkManager.getPurchases(path: "/clothes") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Одежда и обувь", imageName: "bag.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "blue")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadCinemaMusicCategory() {
        networkManager.getPurchases(path: "/cinema-and-music") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Онлайн кино и музыка", imageName: "music.note.tv.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "azure")!)
                self.categories.append(category)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadBeautyCategory() {
        networkManager.getPurchases(path: "/beauty-and-cosmetics") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Салоны красоты и косметики", imageName: "sparkles", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "yellow")!)
                self.categories.append(category)
                self.sortByDecreaseExpenses()
                self.configureChart()
                self.expensesTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

