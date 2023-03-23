//
//  IngredientsDB.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 22.03.2023.
//

import Foundation
import FirebaseFirestore

struct IngredientDB: Equatable {
    var name: String

    var representation: [String: Any] {
        var representation = [String: Any]()
        representation["name"] = self.name
        return representation
    }

    init(name: String) {
        self.name = name
    }

    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let name = data["name"] as? String else { return nil }
        self.name = name
    }
}
