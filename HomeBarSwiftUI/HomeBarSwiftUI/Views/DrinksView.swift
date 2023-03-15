//
//  DrinksView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.03.2023.
//

import SwiftUI

struct DrinksView: View {
    @StateObject var alcoTestViewModel: AlcoTestViewModel
    private let drinks = Drink.getDrinks()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        
        VStack {
            Rectangle()
                .foregroundColor(.gray.opacity(0.7))
                .frame(width: 50, height: 5)
                .cornerRadius(20)
                .padding(EdgeInsets(top: 10, leading: 0, bottom: 5, trailing: 0))
            List {
                ForEach(drinks, id: \.name) { drink in
                    Button {
                        alcoTestViewModel.alcoholValue = drink.alcohol
                        alcoTestViewModel.nameAlcohol = drink.name
                        dismiss.callAsFunction()
                    } label: {
                        Text(drink.name)
                            .foregroundColor(Color("neonOrange"))
                            .font(.system(size: 20))
                    }
                }
                .listRowBackground(Color.gray.opacity(0.2))
            }
            .scrollContentBackground(.hidden)
        }
        .presentationDetents([.medium])
        .background(Color.black)
    }
}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView(alcoTestViewModel: AlcoTestViewModel())
    }
}
