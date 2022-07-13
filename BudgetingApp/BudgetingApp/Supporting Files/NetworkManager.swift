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

struct LoginResponse: Codable {
//    let token: String?
    let message: String?
//    let success: Bool?
}

struct PurchaseResponse: Decodable {
    let expenditure: Double
    let bonus: Double
    let potentialBonus: Double
}

//{
//  "expenditure": 18888,
//  "bonus": 1888.8000000000002,
//  "potentialBonus": 377.76
//}

class NetworkManager {

    static var shared = NetworkManager()

    let link = "http://64.227.72.181:8080/rooms"

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
//                completion(.failure(.custom(errorMessage: "No data")))
                print("No data")
                return
            }
            
//            print(response)
            
//            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
//
//                print(".invalidCredentials")
////                DispatchQueue.main.async {
////                    completion(.failure(.invalidCredentials))
////                }
//                return
//            }
            
//            guard let token = loginResponse.token else {
//                DispatchQueue.main.async {
//                    completion(.failure(.invalidCredentials))
//                }
//                return
//            }
            print("Success")
//            DispatchQueue.main.async {
//                completion(.success(loginResponse.message!))
//            }
        }.resume()
    }
    
        func getGamesPurchases() {
            guard let url = URL(string: "http://localhost:8080/user/info") else {
//                DispatchQueue.main.async {
//                    completion(.failure(.invalidURL))
//                }
                return
            }
    
            let request = URLRequest(url: url)
//            request.addValue(token, forHTTPHeaderField: "Authorization")
    
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data, error == nil else {
//                    DispatchQueue.main.async {
//                        completion(.failure(.noData))
//                    }
                    print("No data")
                    return
                }
                
                guard let purchases = try? JSONDecoder().decode(PurchaseResponse.self, from: data) else {
//                    DispatchQueue.main.async {
//                        completion(.failure(.decodingError))
//                    }
                    print("Decoding error")
                    return
                }
                print(purchases)
            
            
//                DispatchQueue.main.async {
//                    completion(.success(reservations))
//                }
    
            }.resume()
        }
    
//    func getReservations(path: Int, token: String, completion: @escaping (Result<[Request], NetworkError>) -> Void) {
//        guard let url = URL(string: "\(link)/\(path)") else {
//            DispatchQueue.main.async {
//                completion(.failure(.invalidURL))
//            }
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.addValue(token, forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            guard let data = data, error == nil else {
//                DispatchQueue.main.async {
//                    completion(.failure(.noData))
//                }
//                return
//            }
//
//            guard let reservations = try? JSONDecoder().decode([Request].self, from: data) else {
//                DispatchQueue.main.async {
//                    completion(.failure(.decodingError))
//                }
//                return
//            }
//            DispatchQueue.main.async {
//                completion(.success(reservations))
//            }
//
//        }.resume()
//    }
//
//    func postReservation(path: Int, token: String, timefrom: String, timeto: String, completion: @escaping (Result<String, AuthenticationError>) -> Void) {
//        guard let url = URL(string: "\(link)/\(path)") else { return }
//
//        var request = URLRequest(url: url)
//
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(token, forHTTPHeaderField: "Authorization")
//        let body: [String: AnyHashable] = [
//            "timefrom": timefrom,
//            "timeto": timeto,
//            "contact": "XXX"
//        ]
//
//        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
//
//        let task = URLSession.shared.dataTask(with: request) { data, _, error in
//            if error != nil {
//                DispatchQueue.main.async {
//                    completion(.failure(.custom(errorMessage: "There is an error")))
//                }
//            }
//            DispatchQueue.main.async {
//                completion(.success("Success!"))
//            }
//        }
//        task.resume()
//    }
    
//    func register(username: String, password: String) {
//        guard let url = URL(string: "http://64.227.72.181:8080/register") else {
//            print("URL is not correct")
//            return
//        }
//        
//        let body = LoginRequestBody(login: username, password: password)
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try? JSONEncoder().encode(body)
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            if error != nil {
//                print("There is an error")
//            }
//            
////            guard let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
////                return
////            }
////
////            guard let token = loginResponse.token else {
////                return
////            }
////            DispatchQueue.main.async {
////                completion(.success(data))
////            }
//            
//        }.resume()
//    }
    
}
