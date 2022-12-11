//
//  AuthService.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 11.12.2022.
//

import Foundation
import FirebaseAuth

typealias FirebaseUser = FirebaseAuth.User

class AuthServices {
    static let shared = AuthServices()

    private init() { }

    private let auth = Auth.auth()

    private var currentUser: FirebaseUser? {
        return auth.currentUser
    }

    func SignUp(email: String,
                password: String,
                completion: @escaping(Result<FirebaseUser, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }
}
