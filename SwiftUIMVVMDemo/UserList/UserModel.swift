//
//  UserModel.swift
//  SwiftUIMVVMDemo
//
//  Created by Bibin Joseph on 22/05/21.
//

import SwiftUI

// MARK: - UserModelCollection
struct UserModelCollection: Codable {
    let page, perPage, total, totalPages: Int
    let users: [User]

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case users = "data"
    }
}

// MARK: - Datum
struct User: Codable, Identifiable, CustomStringConvertible, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}



/// This will enamble, description property on every codable objects. Easy for debug purposes.
extension CustomStringConvertible where Self: Codable {
    
    var description: String {
        var description = "\n \(type(of: self)) \n"
        let selfMirror = Mirror(reflecting: self)
        for child in selfMirror.children {
            if let propertyName = child.label {
                description += "\(propertyName): \(child.value)\n"
            }
        }
        return description
    }
}
