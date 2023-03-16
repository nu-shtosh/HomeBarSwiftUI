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
        ZStack {
            Rectangle()
                .background(Color.black.opacity(0.5))
                .background(Color.blue.opacity(0.01))
                .background(.ultraThinMaterial.opacity(0.7))
                .environment(\.colorScheme, .light)
                .ignoresSafeArea()
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
                    .listRowBackground(Color(UIColor.darkGray).opacity(0.7))
                    
                }
                .scrollContentBackground(.hidden)
            }
            .presentationDetents([.medium, .large])
            .background(Color.clear)
    }
}

struct DrinksView_Previews: PreviewProvider {
    static var previews: some View {
        DrinksView(alcoTestViewModel: AlcoTestViewModel())
    }
}
