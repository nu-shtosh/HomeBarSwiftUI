//
//  User.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 12.12.2022.
//

import Foundation

struct UserDB: Identifiable {
    var id: String
    var name: String
    var surname: String
    var age: Int
    
    var fullname: String {
        "\(name) \(surname)"
    }

    var representation: [String: Any] {
        var userRepresentation = [String: Any]()
        userRepresentation["id"] = self.id
        userRepresentation["name"] = self.name
        userRepresentation["surname"] = self.surname
        userRepresentation["age"] = self.age
        return userRepresentation
    }
}

