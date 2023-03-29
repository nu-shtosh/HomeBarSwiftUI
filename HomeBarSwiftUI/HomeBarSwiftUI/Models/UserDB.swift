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
    var age: String
    var email: String
    var favoritesCocktails: [String]
    
    var fullname: String {
        "\(name) \(surname)"
    }

    var representation: [String: Any] {
        var representation = [String: Any]()
        representation["id"] = self.id
        representation["name"] = self.name
        representation["surname"] = self.surname
        representation["age"] = self.age
        representation["email"] = self.email
        representation["favoritesCocktails"] = self.favoritesCocktails
        return representation
    }
}

