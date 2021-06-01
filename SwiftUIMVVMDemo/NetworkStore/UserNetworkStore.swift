//
//  UserNetworkStore.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 22/05/21.
//

import Foundation
import Combine
//https://reqres.in/api/users?page=2
//https://reqres.in/api/users/2
//https://reqres.in/api/login


protocol NetworkStore {
    var hostURLString: String { get }
}

extension NetworkStore {
    var hostURLString: String { "https://reqres.in/api/" }
}

protocol UserNetworkStore: NetworkStore {
    func login(email: String, password: String) -> AnyPublisher<Session, Error>
    
    func getUsers(pageNumber: Int) -> AnyPublisher<UserModelCollection, Error>
    
//    func getUserDetail(id: Int) -> AnyPublisher<User, Error>
}

struct UserNetwork: UserNetworkStore {
    func login(email: String, password: String) -> AnyPublisher<Session, Error> {
        let params = ["email": email,
                      "password":password]
        let url = URL(string: hostURLString + "login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try! JSONSerialization.data(withJSONObject: params)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {
                print(String(data: $0.data, encoding: .utf8))
                return $0.data
            }
            .decode(type: Session.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    
    func getUsers(pageNumber: Int) -> AnyPublisher<UserModelCollection, Error> {
        var urlComponent = URLComponents(string: hostURLString + "users")
        urlComponent?.queryItems = [.init(name: "page", value: "\(pageNumber)")]
        
        return URLSession.shared.dataTaskPublisher(for: urlComponent!.url!)
            .map { $0.data }
            .decode(type: UserModelCollection.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
