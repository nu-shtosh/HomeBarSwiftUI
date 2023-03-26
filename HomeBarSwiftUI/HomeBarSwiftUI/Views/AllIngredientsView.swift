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

    @StateObject var cocktailViewModel: CocktailsViewModel

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
        // MARK: - Nav Bar Title
        .navigationTitle("Ingredients")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            // MARK: - Unselect All Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    clearList(&selectedIngredients)
                } label: {
                    Text("Unselect All")
                        .foregroundColor(selectedIngredients.count == 0 ? .secondary : Color("neonOrange"))
                        .disabled(selectedIngredients.count == 0)
                }
            }

            // MARK: - Show Cocktails With Selected Ingredients Button
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    CocktailsWithSelectedIngredientsView(cocktailViewModel: cocktailViewModel,
                                                         ingredients: selectedIngredients)
                } label: {
                    Text("Show Cocktails")
                        .foregroundColor(selectedIngredients.count == 0 ? .secondary : Color("neonOrange"))
                        .disabled(selectedIngredients.count == 0)

                }
                .onAppear {
                    print(selectedIngredients)
                }
            }
        }
    } // End Body

    // MARK: - Check Item In List
    private func checkItemInList(_ list: [String], _ item: String) -> Bool {
        list.contains(item) ? true : false
    }

    // MARK: - Add Item In List
    func addItemInList(_ list: inout [String], _ item: String) {
        if checkItemInList(list, item) {
            deleteItemFromList(&list, item)
        } else {
            list.append(item)
        }
    }

    // MARK: - Delete Item From List
    func deleteItemFromList(_ list: inout [String], _ item: String) {
        if checkItemInList(list, item) {
            if let index = list.firstIndex(of: item) {
                list.remove(at: index )
            }
        } else {
            addItemInList(&list, item)
        }
    }

    // MARK: - Clear List
    func clearList(_ list: inout [String]) {
        list.removeAll()
    }
}
