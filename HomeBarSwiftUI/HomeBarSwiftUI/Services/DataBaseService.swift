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
    private var cocktailReference: CollectionReference { database.collection("NewCocktails")}

    private init () { }
    
    func deleteNewCocktail(cocktail: String) {
        cocktailReference.document(cocktail).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
    }
    
    func setCocktail(cocktail: CocktailDB, image: Data?, completion: @escaping (Result<CocktailDB, Error>) -> ()) {
        if let image = image {
            StorageService.shared.uploadCocktailImage(id: cocktail.name, image: image) { result in
                switch result {
                case .success(_):
                    self.cocktailReference.document(cocktail.name).setData(cocktail.representation) { error in
                        if let error {
                            completion(.failure(error))
                            print(error.localizedDescription)
                        } else {
                            completion(.success(cocktail))
                        }
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } else {
            self.cocktailReference.document(cocktail.name).setData(cocktail.representation) { error in
                if let error {
                    completion(.failure(error))
                } else {
                    completion(.success(cocktail))
                }
            }
        }
    }
    
    func setProfile(user: UserDB, image: Data?, completion: @escaping (Result<UserDB, Error>) -> ()) {
        if let image = image {
            StorageService.shared.uploadUserImage(id: user.id, image: image) { result in
                switch result {
                case .success(_):
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
            guard let email = data["email"] as? String else { return }
            guard let favoritesCocktails = data["favoritesCocktails"] as? [String] else { return }
            let user = UserDB(id: id, name: name, surname: surname, age: age, email: email, favoritesCocktails: favoritesCocktails)
            completion(.success(user))
        }
    }
    func getNewCocktails(completion: @escaping (Result<[CocktailDB], Error>) -> Void) {
        let cocktailsReference = database.collection("NewCocktails")
        cocktailsReference.getDocuments { querySnapshot, error in
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

    func getCocktails(completion: @escaping (Result<[CocktailDB], Error>) -> Void) {
        let cocktailsReference = database.collection("Cocktails")
            .limit(to: 5)

        //            .limit(to: 10)
        //
        //            .order(by: "name")
        //            .start(at: ["S"])
        //            .end(at: ["Y"])
        //            .whereField("name", in: ["Mojito"])
        //            .order(by: "ingredients")
        //            .whereField("ingredients.Lime.Sugar", notIn: [""])
        //            .whereField("ingredients", in: ["Sugar"])
        //            .whereField("ingredients", isEqualTo: "Coconut")
        //            .whereField("Sugar", arrayContainsAny: [""])

        // играясь с этими параметрами, можно прикольную сортировку сделать
        // с сервера будут грузиться меньше данных, (в этом примере грузятся только те коктейли, которые начинаются на "W", так же можно сделать порционную загрузку, разбив по 50, 100 и т.д.
        // есть еще .limit(to:) и .limit(to last:) который тупо ограничивает количество данных, то есть
        // .limit(to: 5) загрузит только 5 коктейлей
        
        cocktailsReference.getDocuments { querySnapshot, error in
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

    func getCocktailsWithSelectedIngredients(_ list: [String],
                                             completion: @escaping (Result<[CocktailDB], Error>) -> Void) {
        let cocktailsReference = database.collection("Cocktails")
            .whereField("ingredientsNames", arrayContainsAny: list)

        cocktailsReference.getDocuments { querySnapshot, error in
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

    func getFavoritesCocktails(_ list: [String],
                                completion: @escaping (Result<[CocktailDB], Error>) -> Void) {
        let cocktailsReference = database.collection("Cocktails")
            .whereField("name", in: list)

        cocktailsReference.getDocuments { querySnapshot, error in
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


    func getIngredients(completion: @escaping (Result<[IngredientDB], Error>) -> Void) {
        let ingredientsReference = database.collection("Ingredients")
            .limit(to: 10)
        ingredientsReference.getDocuments { querySnapshot, error in
            guard let querySnapshot else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            let documents = querySnapshot.documents
            var ingredients = [IngredientDB]()
            for document in documents {
                guard let ingredient = IngredientDB.init(document: document) else { return }
                ingredients.append(ingredient)
            }
            completion(.success(ingredients))
        }
    }
}

class CocktailData : ObservableObject {

    var cocktails: DrinksFromAPI?

    func fetchEpisodeSchedule() {
        NetworkManager.shared.fetch(DrinksFromAPI.self, from: Link.scheduleURL.rawValue) { [weak self] result in
            switch result {
            case .success(let cocktailFromAPI):
                let db = Firestore.firestore()
                let ref = db.collection("Cocktails").document(cocktailFromAPI.drinks[0].idDrink ?? "1")

                var ingredientsNames = [String]()
                var ingredientsMeasures = [String]()

                for cocktail in cocktailFromAPI.drinks {
                    if let cocktailIngredient1 = cocktail.strIngredient1,
                       let cocktailMeasure1 = cocktail.strMeasure1 {
                        ingredientsNames.append(cocktailIngredient1)
                        ingredientsMeasures.append(cocktailMeasure1)
                    }
                    if let cocktailIngredient2 = cocktail.strIngredient2,
                       let cocktailMeasure2 = cocktail.strMeasure2 {
                        ingredientsNames.append(cocktailIngredient2)
                        ingredientsMeasures.append(cocktailMeasure2)
                    }
                    if let cocktailIngredient3 = cocktail.strIngredient3,
                       let cocktailMeasure3 = cocktail.strMeasure3 {
                        ingredientsNames.append(cocktailIngredient3)
                        ingredientsMeasures.append(cocktailMeasure3)
                    }
                    if let cocktailIngredient4 = cocktail.strIngredient4,
                       let cocktailMeasure4 = cocktail.strMeasure4 {
                        ingredientsNames.append(cocktailIngredient4)
                        ingredientsMeasures.append(cocktailMeasure4)
                    }
                    if let cocktailIngredient5 = cocktail.strIngredient5,
                       let cocktailMeasure5 = cocktail.strMeasure5 {
                        ingredientsNames.append(cocktailIngredient5)
                        ingredientsMeasures.append(cocktailMeasure5)
                    }
                    if let cocktailIngredient6 = cocktail.strIngredient6,
                       let cocktailMeasure6 = cocktail.strMeasure6 {
                        ingredientsNames.append(cocktailIngredient6)
                        ingredientsMeasures.append(cocktailMeasure6)
                    }
                    if let cocktailIngredient7 = cocktail.strIngredient7,
                       let cocktailMeasure7 = cocktail.strMeasure7 {
                        ingredientsNames.append(cocktailIngredient7)
                        ingredientsMeasures.append(cocktailMeasure7)
                    }
                    if let cocktailIngredient8 = cocktail.strIngredient8,
                       let cocktailMeasure8 = cocktail.strMeasure8 {
                        ingredientsNames.append(cocktailIngredient8)
                        ingredientsMeasures.append(cocktailMeasure8)
                    }
                    if let cocktailIngredient9 = cocktail.strIngredient9,
                       let cocktailMeasure9 = cocktail.strMeasure9 {
                        ingredientsNames.append(cocktailIngredient9)
                        ingredientsMeasures.append(cocktailMeasure9)
                    }
                    if let cocktailIngredient10 = cocktail.strIngredient10,
                       let cocktailMeasure10 = cocktail.strMeasure10 {
                        ingredientsNames.append(cocktailIngredient10)
                        ingredientsMeasures.append(cocktailMeasure10)
                    }
                    if let cocktailIngredient11 = cocktail.strIngredient11,
                       let cocktailMeasure11 = cocktail.strMeasure11 {
                        ingredientsNames.append(cocktailIngredient11)
                        ingredientsMeasures.append(cocktailMeasure11)
                    }
                    if let cocktailIngredient12 = cocktail.strIngredient12,
                       let cocktailMeasure12 = cocktail.strMeasure12 {
                        ingredientsNames.append(cocktailIngredient12)
                        ingredientsMeasures.append(cocktailMeasure12)
                    }
                    if let cocktailIngredient13 = cocktail.strIngredient13,
                       let cocktailMeasure13 = cocktail.strMeasure13 {
                        ingredientsNames.append(cocktailIngredient13)
                        ingredientsMeasures.append(cocktailMeasure13)
                    }
                    if let cocktailIngredient14 = cocktail.strIngredient14,
                       let cocktailMeasure14 = cocktail.strMeasure14 {
                        ingredientsNames.append(cocktailIngredient14)
                        ingredientsMeasures.append(cocktailMeasure14)
                    }
                    if let cocktailIngredient15 = cocktail.strIngredient15,
                       let cocktailMeasure15 = cocktail.strMeasure15 {
                        ingredientsNames.append(cocktailIngredient15)
                        ingredientsMeasures.append(cocktailMeasure15)
                    }

                    ref.setData([
                        "name": cocktail.strDrink ?? "",
                        "tags": cocktail.strTags ?? "",
                        "alcoholic": cocktail.strAlcoholic ?? "",
                        "instructions": cocktail.strInstructions ?? "",
                        "image": cocktail.strDrinkThumb ?? "",
                        "ingredientsNames": ingredientsNames.count > 0 ? ingredientsNames : [""],
                        "ingredientsMeasures": ingredientsMeasures.count > 0 ? ingredientsMeasures : [""],
                        "rating": 0,
                        "numberOfRatings": 0,
                        "sumOfRating": 0,
                        "userRating": 0,
                        "like": 0,
                        "idUser": "",
                        "comments": [
                            "user": "",
                            "title": "",
                            "text": "",
                            "likes": 0
                        ]
                    ]) { error in
                        if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }
                self?.cocktails = cocktailFromAPI
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchIngredients() {
        let ingredients = IngredientDataStorage().ingredients
        let db = Firestore.firestore()
        let ref = db.collection("AllIngredients").document("ingredients")
        ref.setData(["ingredients": ingredients])
    }
}
