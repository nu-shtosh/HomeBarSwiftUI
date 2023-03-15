//
//  ResultAlcoTestView.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 14.03.2023.
//

import SwiftUI

struct ResultAlcoTestView: View {
    @StateObject var alcoTestViewModel: AlcoTestViewModel
    
    var body: some View {
        ZStack {
            WallpaperView()
            VStack {
                Spacer()
                VStack() {
                    Text("The blood alcohol level is")
                        .foregroundColor(.white)
                    HStack {
                        Text("approximately")
                            .foregroundColor(.white)
                        Text(alcoTestViewModel.resultFormatted)
                            .foregroundColor(Color("neonOrange"))
                            .font(.title3)
                        
                        Text(alcoTestViewModel.promile)
                            .foregroundColor(.white)
                    }
                }
                Spacer()
                Image(alcoTestViewModel.resultImage)
                    .resizable()
                    .frame(width: 260, height: 300)
                Spacer()
                Text(alcoTestViewModel.motivatingText)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                Spacer()
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Result")
        }
        .onAppear {
            alcoTestViewModel.loadData()
        }
    }
}

struct ResultAlcoTestView_Previews: PreviewProvider {
    static var previews: some View {
        ResultAlcoTestView(alcoTestViewModel: AlcoTestViewModel())
    }
}

