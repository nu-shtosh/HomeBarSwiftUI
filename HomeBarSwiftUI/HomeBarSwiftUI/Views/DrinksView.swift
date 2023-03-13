//
//  DrinksView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import SwiftUI

struct DrinksView: View {
    @StateObject var alcoTestViewModel: AlcoTestViewModel
    let drinks = Drink.getDrinks()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button(action: dismiss.callAsFunction) {
                    Text("Done")
                        .foregroundColor(Color("neonOrange"))
                }
            }
            .padding()
            List {
                ForEach(drinks, id: \.name) { drink in
                    Button {
                        alcoTestViewModel.alcoholValue = drink.alcohol
                        alcoTestViewModel.nameAlcohol = drink.name
                        dismiss.callAsFunction()
                    } label: {
                        Text(drink.name)
                            .foregroundColor(Color("neonOrange"))
                    }
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
            .scrollContentBackground(.hidden)
        }
        .background(Color.black)
    }
    
}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView(alcoTestViewModel: AlcoTestViewModel())
    }
}
