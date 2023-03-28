//
//  SearchView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 23.03.2023.
//

import SwiftUI

struct SearchView: View {
    @Binding var text: String
    @Binding var isEditing: Bool
    
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray3))
                .cornerRadius(8)
                .overlay {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)
                        
                        if isEditing {
                            Button {
                                text = ""
                            } label: {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }

                        }
                    }
                }
                .padding(.horizontal, 16)
                .onTapGesture {
                    isEditing = true
                }
            if isEditing {
                Button {
                    isEditing = false
                    text = ""
                } label: {
                    Text("Cancel")
                        .foregroundColor(Color("neonBlue"))
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing)
                .animation(.default))

            }
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(text: .constant(""), isEditing: .constant(true))
    }
}
