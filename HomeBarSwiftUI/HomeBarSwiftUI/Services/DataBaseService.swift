//
//  DataBaseService.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 12.12.2022.
//

import Foundation
import FirebaseFirestore

class DataBaseService {

    static let shared = DataBaseService()
    private let database = Firestore.firestore() // ссылка на нашу бд на сервере

    private var usersReference: CollectionReference {
        database.collection("Users")
    }

    private init () { }

    func setupUser(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {
        usersReference.document(user.id).setData(user.representation) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }
}
