//
//  SecondViewController.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 09.07.2022.
//

import UIKit
import Charts

class SecondViewController: UIViewController {
    
    private var networkManager = NetworkManager.shared
    
    private let historyLabel: UILabel = {
        let label = UILabel()
        label.text = "Расходы за прошлые месяцы:"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    private let historyChart = BarChartView()
    private let backgroundViewForChart: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 40
        return view
    }()
    private let forecastedExpensesTable: UITableView = {
        let table = UITableView()
        table.layer.cornerRadius = 30
        table.showsVerticalScrollIndicator = false
        return table
    }()
    private let monthlyLabel: UILabel = {
        let label = UILabel()
        label.text = "Ежемесячные расходы:"
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        return label
    }()
    private let button: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 25
        
        let config = UIImage.SymbolConfiguration(pointSize: 35)
        button.setImage(UIImage(systemName: "plus", withConfiguration: config), for: .normal)
        button.tintColor = .orange
        button.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        return button
    }()
    private let totalLabel = UILabel()
    
    let data = [
        [0,121560],
        [1,106090],
        [2,143420],
        [3,95080],
        [4,169010],
        [5,109050]
    ]
    var monthlyExpenses: [Category] = [] {
        didSet {
            var sum = 0.0
            for index in 0..<monthlyExpenses.count {
                sum += monthlyExpenses[index].expense
            }
            let boldAttribute = [
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)
            ]
            let regularAttribute = [
               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18.0)
            ]
            let boldText = NSAttributedString(string: "Итого:", attributes: boldAttribute)
            let regularText = NSAttributedString(string: "  \(sum)", attributes: regularAttribute)
            let newString = NSMutableAttributedString()
            newString.append(boldText)
            newString.append(regularText)
            totalLabel.attributedText = newString
        }
    }
    let months = ["January", "February", "March", "April", "May", "June"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        loadCategories()
        makeConstraints()
        configureTable()
    }
    
    @objc private func addButtonPressed() {
        UIView.animate(withDuration: 0.5, animations: { [self] in
            button.transform = CGAffineTransform(rotationAngle: CGFloat.pi*2/3)
        })
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 270,height: 250)
        
        let categoryLabel = UILabel(frame: CGRect(x: 16, y: 0, width: 270, height: 30))
        categoryLabel.text = "Выберите категорию:"
        vc.view.addSubview(categoryLabel)
        
        let pickerView = UIPickerView(frame: CGRect(x: 16, y: 30, width: 238, height: 150))
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.backgroundColor = .white
        pickerView.layer.cornerRadius = 10
        vc.view.addSubview(pickerView)
        
        let enterLabel = UILabel(frame: CGRect(x: 16, y: 200, width: 140, height: 30))
        enterLabel.text = "Введите сумму:"
        vc.view.addSubview(enterLabel)
        
        let expenseField = UITextField(frame: CGRect(x: 150, y: 200, width: 100, height: 30))
        expenseField.placeholder = "тг"
        expenseField.textAlignment = .right
        expenseField.layer.borderWidth = 2
        expenseField.layer.cornerRadius = 5
        expenseField.layer.borderColor = UIColor.systemGray.cgColor
        expenseField.setRightPaddingPoints(10)
        expenseField.becomeFirstResponder()
        expenseField.clearButtonMode = .whileEditing
        expenseField.delegate = self
        vc.view.addSubview(expenseField)
        
        let editRadiusAlert = UIAlertController(title: "Добавить расход", message: nil, preferredStyle: .alert)
        editRadiusAlert.setValue(vc, forKey: "contentViewController")
        
        editRadiusAlert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [self] _ in
            if expenseField.hasText {
                
                for index in 0..<monthlyExpenses.count {
                    if monthlyExpenses[index].name == Category.categories[pickerView.selectedRow(inComponent: 0)].name {
                        monthlyExpenses[index].expense += Double(expenseField.text!)!
                        sortByDecreaseExpenses()
                        forecastedExpensesTable.reloadData()
                        UIView.animate(withDuration: 0.5, animations: { [self] in
                            button.transform = .identity
                        })
                        return
                    }
                }
                
                let selectedCategory = Category.categories[pickerView.selectedRow(inComponent: 0)]
                let newExpense = Category(name: selectedCategory.name, imageName: selectedCategory.imageName, expense: Double(expenseField.text!)!, bonus: 0, color: selectedCategory.color)
                monthlyExpenses.append(newExpense)
                sortByDecreaseExpenses()
                forecastedExpensesTable.reloadData()
                
                UIView.animate(withDuration: 0.5, animations: { [self] in
                    button.transform = .identity
                })
            }
        }))
        
        editRadiusAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in
            UIView.animate(withDuration: 0.5, animations: { [self] in
                button.transform = .identity
            })
        }))
        
        self.present(editRadiusAlert, animated: true)
    }
    
    private func sortByDecreaseExpenses() {
        monthlyExpenses = monthlyExpenses.sorted(by: { $0.expense > $1.expense })
    }
    
    private func loadCategories() {
        loadTaxiCategory()
        loadRestaurantsCategory()
        loadGamesCategory()
        loadFitnessCategory()
        loadCinemaMusicCategory()
    }
    
    private func configureTable() {
        forecastedExpensesTable.register(MonthlyExpensesCell.self, forCellReuseIdentifier: "monthlyExpensesCell")
        forecastedExpensesTable.delegate = self
        forecastedExpensesTable.dataSource = self
    }
    
    private func configureChart() {
        var dataEntries: [BarChartDataEntry] = []
        let color: [UIColor] = [UIColor(named: "orange")!]

        for index in 0..<data.count {
            let entry = BarChartDataEntry(x: Double(data[index][0]), y: Double(data[index][1]))
            dataEntries.append(entry)
        }

        let barChartDataSet = BarChartDataSet(entries: dataEntries)

        barChartDataSet.colors = color
        barChartDataSet.valueFont = UIFont(name: "Arial", size: 18)!
//        barChartDataSet.drawValuesEnabled = false

        historyChart.data = BarChartData(dataSet: barChartDataSet)

        historyChart.legend.enabled = false
        historyChart.setVisibleXRangeMaximum(4)
        historyChart.moveViewToX(Double(data.count - 1))

        // Hiding grid
        historyChart.leftAxis.enabled = false
        historyChart.rightAxis.enabled = false
        historyChart.xAxis.enabled = false

        // Setting left axis
        historyChart.leftAxis.setLabelCount(6, force: true)
        historyChart.leftAxis.axisMinimum = 0.0
        historyChart.leftAxis.axisMaximum = ceil(Double(data.map({ $0.max()!}).max()!) + Double(data.map({ $0.max()!}).max()!) / 6)

        // Average line
        let averageExpenses = 5.6
        let expensesAverageLine = ChartLimitLine()
        expensesAverageLine.limit = averageExpenses
        expensesAverageLine.lineColor = .systemGray2
        expensesAverageLine.valueTextColor = .systemGray
        expensesAverageLine.label = "Average: \(averageExpenses)"
        expensesAverageLine.labelPosition = .bottomLeft
        historyChart.leftAxis.addLimitLine(expensesAverageLine)

        // X-axis labels
        historyChart.animate(yAxisDuration: 1)
        historyChart.xAxis.valueFormatter = IndexAxisValueFormatter(values: months)
        historyChart.xAxis.labelRotationAngle = -25
        historyChart.xAxis.labelPosition = .bottomInside
//        historyChart.gridBackgroundColor = NSUIColor.white
    }
    
    private func makeConstraints() {
        view.addSubview(historyLabel)
        historyLabel.translatesAutoresizingMaskIntoConstraints = false
        historyLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        historyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        historyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        historyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(backgroundViewForChart)
        backgroundViewForChart.translatesAutoresizingMaskIntoConstraints = false
        backgroundViewForChart.topAnchor.constraint(equalTo: historyLabel.bottomAnchor, constant: 16).isActive = true
        backgroundViewForChart.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        backgroundViewForChart.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        backgroundViewForChart.heightAnchor.constraint(equalToConstant: 280).isActive = true
        
        backgroundViewForChart.addSubview(historyChart)
        historyChart.translatesAutoresizingMaskIntoConstraints = false
        historyChart.topAnchor.constraint(equalTo: backgroundViewForChart.topAnchor, constant: 8).isActive = true
        historyChart.leadingAnchor.constraint(equalTo: backgroundViewForChart.leadingAnchor, constant: 8).isActive = true
        historyChart.trailingAnchor.constraint(equalTo: backgroundViewForChart.trailingAnchor, constant: -8).isActive = true
        historyChart.bottomAnchor.constraint(equalTo: backgroundViewForChart.bottomAnchor, constant: -8).isActive = true
        
        view.addSubview(monthlyLabel)
        monthlyLabel.translatesAutoresizingMaskIntoConstraints = false
        monthlyLabel.topAnchor.constraint(equalTo: backgroundViewForChart.bottomAnchor, constant: 16).isActive = true
        monthlyLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        monthlyLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        monthlyLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        view.addSubview(forecastedExpensesTable)
        forecastedExpensesTable.translatesAutoresizingMaskIntoConstraints = false
        forecastedExpensesTable.topAnchor.constraint(equalTo: monthlyLabel.bottomAnchor, constant: 16).isActive = true
        forecastedExpensesTable.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        forecastedExpensesTable.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        forecastedExpensesTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.trailingAnchor.constraint(equalTo: forecastedExpensesTable.trailingAnchor, constant: -16).isActive = true
        button.bottomAnchor.constraint(equalTo: forecastedExpensesTable.bottomAnchor, constant: -16).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        view.addSubview(totalLabel)
        totalLabel.translatesAutoresizingMaskIntoConstraints = false
        totalLabel.topAnchor.constraint(equalTo: forecastedExpensesTable.bottomAnchor, constant: 16).isActive = true
        totalLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -55).isActive = true
    }
}

//MARK: - TableView Delegates
extension SecondViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyExpenses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "monthlyExpensesCell", for: indexPath) as! MonthlyExpensesCell
        cell.assignParameters(monthlyExpenses[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            monthlyExpenses.remove(at: indexPath.row)
            forecastedExpensesTable.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

// MARK: - PickerView Delegates
extension SecondViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Category.categories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label: UILabel

        if let view = view {
            label = view as! UILabel
        }
        else {
            label = UILabel(frame: CGRect(x: 0, y: 0, width: pickerView.frame.width, height: 400))
        }

        label.text = Category.categories[row].name
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = UIFont(name: "Arial", size: 20)
        label.sizeToFit()
        label.textAlignment = .center

        return label
    }
    
}

// MARK: - Setting TextField to accept only numbers
extension SecondViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

// MARK: - Setting TextField padding
extension UITextField {
    func setRightPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

// MARK: - Loading monthly expenses
extension SecondViewController {
    func loadTaxiCategory() {
        networkManager.getPurchases(path: "/taxi") { (result) in
            switch result {
            case .success(let purchases):
                let category = Category(name: "Такси", imageName: "car.circle.fill", expense: purchases.expenditure, bonus: purchases.bonus, color: UIColor(named: "orange")!)
                self.monthlyExpenses.append(category)
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
                self.monthlyExpenses.append(category)
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
                self.monthlyExpenses.append(category)
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
                self.monthlyExpenses.append(category)
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
                self.monthlyExpenses.append(category)
                self.sortByDecreaseExpenses()
                self.configureChart()
                self.forecastedExpensesTable.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
