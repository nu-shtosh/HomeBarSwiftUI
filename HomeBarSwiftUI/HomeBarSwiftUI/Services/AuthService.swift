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

    var currentUser: FirebaseUser? {
        return auth.currentUser
    }

    func signUp(email: String,
                password: String,
                completion: @escaping(Result<FirebaseUser, Error>) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let result {
                let userModel = UserModel(id: result.user.uid,
                                          name: "",
                                          surname: "",
                                          age: 0)
                DataBaseService.shared.setupUser(user: userModel) { resultDataBase in
                    switch resultDataBase {
                    case .success(_):
                        completion(.success(result.user))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    func signIn(email: String,
                password: String,
                completion: @escaping(Result<FirebaseUser, Error>) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }
}
