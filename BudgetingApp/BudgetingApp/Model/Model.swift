//
//  Model.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 08.07.2022.
//

import UIKit

struct Category {
    let name: String
    let imageName: String
    var expense: Double
    let bonus: Double
    let color: UIColor
    
    static let categories: [Category] = [
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
}



