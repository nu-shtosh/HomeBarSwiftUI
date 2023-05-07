//
//  StrorageService.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 18.12.2022.
//

import Foundation
import FirebaseStorage

class StorageService {
    
    static let shared = StorageService()
    
    private let storage = Storage.storage().reference()
    private var userRef: StorageReference { storage.child("usersPhoto")}
    private var cocktailRef: StorageReference { storage.child("cocktailPhoto")}
    
    func deleteUserImage(id: String) {
        userRef.child(id).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("delete image")
            }
        }
    }
    
    func deleteCocktailImage(id: String) {
        cocktailRef.child(id).delete { error in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("delete image")
            }
        }
    }
    
    func uploadCocktailImage(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        cocktailRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metadata.size)"))
        }
    }
    
    func downloadCocktailImage(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        cocktailRef.child(id).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
    
    func uploadUserImage(id: String, image: Data, completion: @escaping (Result<String, Error>) -> Void) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"
        userRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata = metadata else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success("Размер полученного изображения: \(metadata.size)"))
        }
        
    }
    
    func downloadUserImage(id: String, completion: @escaping (Result<Data, Error>) -> Void) {
        userRef.child(id).getData(maxSize: 2 * 1024 * 1024) { data, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
    
   
    
    private init() {}
}
