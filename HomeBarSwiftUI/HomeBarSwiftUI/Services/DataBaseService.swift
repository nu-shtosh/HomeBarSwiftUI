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

    private var usersReference: CollectionReference { database.collection("Users") }
    private var cocktailsReference: CollectionReference { database.collection("Cocktails") }
    
    private init () { }
    
    func setProfile(user: UserDB, image: Data?, completion: @escaping (Result<UserDB, Error>) -> ()) {
        if let image = image {
            StorageService.shared.uploadUserImage(id: user.id, image: image) { result in
                switch result {
                case .success(let sizeInfo):
                    print(sizeInfo)
                    self.usersReference.document(user.id).setData(user.representation) { error in
                        if let error {
                            completion(.failure(error))
                        } else {
                            completion(.success(user))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            self.usersReference.document(user.id).setData(user.representation) { error in
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(user))
                }
            }
        }
    }
    
    func getProfile(completion: @escaping (Result<UserDB, Error>) -> Void) {
        usersReference.document(AuthServices.shared.currentUser!.uid).getDocument { docSnapshot, error  in
            guard let snapshot = docSnapshot else { return }
            guard let data = snapshot.data() else { return }
            guard let name = data["name"] as? String else { return }
            guard let age = data["age"] as? String else { return }
            guard let id = data["id"] as? String  else { return }
            guard let surname = data["surname"] as? String else { return }
            
            let user = UserDB(id: id, name: name, surname: surname, age: age)
            
            completion(.success(user))
        }
    }

    func getCocktails(completion: @escaping (Result<[CocktailDB], Error>) -> ()) {
        self.cocktailsReference.getDocuments { querySnapshot, error in
            guard let querySnapshot else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            let documents = querySnapshot.documents
            var cocktails = [CocktailDB]()

            for document in documents {
                guard let cocktail = CocktailDB.init(document: document) else { return }
                cocktails.append(cocktail)
            }
            completion(.success(cocktails))
        }
    }
}

class CocktailData : ObservableObject{

    var cocktails: DrinksFromAPI?

    func fetchEpisodeSchedule() {
        NetworkManager.shared.fetch(DrinksFromAPI.self, from: Link.scheduleURL.rawValue) { [weak self] result in
            switch result {
            case .success(let schedule):
                let db = Firestore.firestore()
                let ref = db.collection("Cocktails").document(schedule.drinks[0].idDrink ?? "1")
                var ingredients: [String: String] = [:]
                for value in schedule.drinks {

                    if let cocktailIngredient1 = value.strIngredient1,
                       let cocktailMeasure1 = value.strMeasure1 {
                        ingredients[cocktailIngredient1] = cocktailMeasure1
                    }
                    if let cocktailIngredient2 = value.strIngredient2,
                       let cocktailMeasure2 = value.strMeasure2 {
                        ingredients[cocktailIngredient2] = cocktailMeasure2
                    }
                    if let cocktailIngredient3 = value.strIngredient3,
                       let cocktailMeasure3 = value.strMeasure3 {
                        ingredients[cocktailIngredient3] = cocktailMeasure3
                    }
                    if let cocktailIngredient4 = value.strIngredient4,
                       let cocktailMeasure4 = value.strMeasure4 {
                        ingredients[cocktailIngredient4] = cocktailMeasure4
                    }
                    if let cocktailIngredient5 = value.strIngredient5,
                       let cocktailMeasure5 = value.strMeasure5 {
                        ingredients[cocktailIngredient5] = cocktailMeasure5
                    }
                    if let cocktailIngredient6 = value.strIngredient6,
                       let cocktailMeasure6 = value.strMeasure6 {
                        ingredients[cocktailIngredient6] = cocktailMeasure6
                    }
                    if let cocktailIngredient7 = value.strIngredient7,
                       let cocktailMeasure7 = value.strMeasure7 {
                        ingredients[cocktailIngredient7] = cocktailMeasure7
                    }
                    if let cocktailIngredient8 = value.strIngredient8,
                        let cocktailMeasure8 = value.strMeasure8 {
                        ingredients[cocktailIngredient8] = cocktailMeasure8
                    }
                    if let cocktailIngredient9 = value.strIngredient9,
                         let cocktailMeasure9 = value.strMeasure9 {
                        ingredients[cocktailIngredient9] = cocktailMeasure9
                    }
                    if let cocktailIngredient10 = value.strIngredient10,
                         let cocktailMeasure10 = value.strMeasure10 {
                        ingredients[cocktailIngredient10] = cocktailMeasure10
                    }
                    if let cocktailIngredient11 = value.strIngredient11,
                        let cocktailMeasure11 = value.strMeasure11 {
                        ingredients[cocktailIngredient11] = cocktailMeasure11
                    }
                    if let cocktailIngredient12 = value.strIngredient12,
                         let cocktailMeasure12 = value.strMeasure12 {
                        ingredients[cocktailIngredient12] = cocktailMeasure12
                    }
                    if let cocktailIngredient13 = value.strIngredient13,
                          let cocktailMeasure13 = value.strMeasure13 {
                        ingredients[cocktailIngredient13] = cocktailMeasure13
                    }
                    if let cocktailIngredient14 = value.strIngredient14,
                         let cocktailMeasure14 = value.strMeasure14 {
                        ingredients[cocktailIngredient14] = cocktailMeasure14
                    }
                    if let cocktailIngredient15 = value.strIngredient15,
                          let cocktailMeasure15 = value.strMeasure15 {
                        ingredients[cocktailIngredient15] = cocktailMeasure15
                    }

                    ref.setData([
                        "name": value.strDrink ?? "",
                        "tags": value.strTags ?? "",
                        "alcoholic": value.strAlcoholic ?? "",
                        "instructions": value.strInstructions ?? "",
                        "image": value.strDrinkThumb ?? "",
                        "ingredients": ingredients,
                        "rating": 0,
                        "numberOfRatings": 0,
                        "sumOfRating": 0,
                        "user rating": 0,
                        "like": 0,
                        "comments": [
                            "user": "name",
                            "title": "title",
                            "text": "text",
                            "likes": 0
                        ]
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }

                self?.cocktails = schedule

                print(schedule)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
