//
//  NetworkManager.swift
//  BudgetingApp
//
//  Created by Olzhas Seiilkhanov on 13.07.2022.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

struct LoginRequestBody: Codable {
    let login: String
    let password: String
}

struct PurchaseResponse: Decodable {
    let expenditure: Double
    let bonus: Double
    let potentialBonus: Double
}

class NetworkManager {

    static var shared = NetworkManager()

    private let session: URLSession

    private init() {
        session = URLSession(configuration: .default)
    }
    
    func auth(username: String, password: String) {
        guard let url = URL(string: "http://localhost:8080/auth") else {
            print("URL is not correct")
            return
        }
        
        let body = LoginRequestBody(login: username, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                print("No data")
                return
            }
            print("Success")
        }.resume()
    }
    
    func getPurchases(path: String, completion: @escaping (Result<PurchaseResponse, NetworkError>) -> Void) {
        guard let url = URL(string: "http://localhost:8080/user\(path)") else {
            DispatchQueue.main.async {
                completion(.failure(.invalidURL))
            }
            return
        }
        
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.noData))
                }
                return
            }
            
            guard let purchases = try? JSONDecoder().decode(PurchaseResponse.self, from: data) else {
                DispatchQueue.main.async {
                    completion(.failure(.decodingError))
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(purchases))
            }
            
        }.resume()
    }
}
