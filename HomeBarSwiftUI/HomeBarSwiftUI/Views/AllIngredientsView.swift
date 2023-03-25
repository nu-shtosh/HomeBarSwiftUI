//
//  AllIngredientsView.swift
//  HomeBarSwiftUI
//
//  Created by Илья Дубенский on 22.03.2023.
//

import SwiftUI

struct AllIngredientsView: View {

    // MARK: - State Object Properties
    @StateObject var ingredientsViewModel: IngredientsViewModel

    private var filteredIngredients: [String] { // 1
        if searchedIngredient.isEmpty {
            return ingredientsViewModel.allIngredients.map { $0.name }
        } else {
            return ingredientsViewModel.allIngredients.map { $0.name }.filter { $0.localizedCaseInsensitiveContains(searchedIngredient) }
        }
    }

    @State private var selectedIngredients: [String] = []

    @Environment(\.dismissSearch) private var dismissSearch

    // MARK: - Properties
    @State private var searchedIngredient = ""

    // MARK: - Body
    var body: some View {
        ZStack() {
            // MARK: - Wallpaper View
            WallpaperView()

            ScrollView {
                // MARK: - All Ingredients
                VStack {
                    // MARK: - Ingredient Cell
                    if filteredIngredients.count > 0 {

                        // MARK: - Ingredients List
                        ForEach(filteredIngredients, id: \.self) { ingredient in
                            HStack {

                                // MARK: - Ingredient Name
                                Text(ingredient)
                                    .foregroundColor(Color("neonOrange"))
                                Spacer()

                                // MARK: - Checkmark
                                if checkItemInList(selectedIngredients, ingredient) {
                                    Image(systemName: "checkmark.circle")
                                        .foregroundColor(Color("neonBlue"))
                                        .opacity(0.8)
                                } else {
                                    Image(systemName: "circle")
                                        .foregroundColor(Color("neonBlue"))
                                        .opacity(0.8)
                                } // End If
                            } // End HStack
                            .animation(.default, value: filteredIngredients.count > 0)
                            .onTapGesture {
                                addItemInList(&selectedIngredients, ingredient)
                                print(selectedIngredients)
                            }
                            if ingredient != filteredIngredients.last {
                                Rectangle()
                                    .frame(height: 1)
                                    .foregroundColor(Color("neonBlue").opacity(0.3))
                            }
                        } // End ForEach
                    } else {
                        Text("Ingredient Not Found")
                            .foregroundColor(Color("neonOrange"))
                    } // End If
                } // End VStack
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                    colors: [Color("neonBlue"), Color("neonOrange")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.3), lineWidth: 2))
                .background(LinearGradient(colors: [Color("neonBlue"),
                                                    Color("neonOrange")],
                                           startPoint: .top,
                                           endPoint: .bottom).opacity(0.15))
                .cornerRadius(16)
                .onAppear{
                    ingredientsViewModel.getIngredients()
                }
            } // End ScrollView

            .padding()
        } // End ZStack
        .searchable(text: $searchedIngredient,
                    placement: .toolbar,
                    prompt: "Search")
        .onSubmit(of: .search) { // 1
            print("Submit")
        }
        .navigationTitle("Ingredients")
        .navigationBarTitleDisplayMode(.large)
    } // End Body


    // MARK: - Check Item
    private func checkItemInList(_ list: [String], _ item: String) -> Bool {
        list.contains(item) ? true : false
    }

    // MARK: - Add Item
    func addItemInList(_ list: inout [String], _ item: String) {
        if checkItemInList(list, item) {
            deleteItemFromList(&list, item)
        } else {
            list.append(item)
        }
    }

    // MARK: - Delete Item
    func deleteItemFromList(_ list: inout [String], _ item: String) {
        if checkItemInList(list, item) {
            if let index = list.firstIndex(of: item) {
                list.remove(at: index )
            }
        } else {
            addItemInList(&list, item)
        }
    }

    
}
