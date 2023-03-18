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
                    Text(alcoTestViewModel.alcoTest.resultOfText)
                        .foregroundColor(.white)
                    HStack {
                        Text(alcoTestViewModel.alcoTest.resultOfTextTwo)
                            .foregroundColor(.white)
                        Text(alcoTestViewModel.alcoTest.resultFormatted)
                            .foregroundColor(Color("neonOrange"))
                            .font(.title3)
                        Text(alcoTestViewModel.alcoTest.promile)
                            .foregroundColor(.white)
                    }
                }
                .padding()
                .background(Color(.gray).opacity(0.2))
                .cornerRadius(20)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                    colors: [Color("neonOrange"), Color("neonBlue")],
                    startPoint: .top,
                    endPoint: .bottom
                ).opacity(0.5), lineWidth: 2))
                
                Image(alcoTestViewModel.alcoTest.resultImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer()
                Text(alcoTestViewModel.alcoTest.motivatingText)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding()
                    .background(Color(.gray).opacity(0.2))
                    .cornerRadius(20)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(LinearGradient(
                        colors: [Color("neonOrange"), Color("neonBlue")],
                        startPoint: .top,
                        endPoint: .bottom
                    ).opacity(0.5), lineWidth: 2))
                Spacer()
                Text(alcoTestViewModel.alcoTest.warningText)
                    .foregroundColor(.red)
                    .multilineTextAlignment(.center)
                
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
        ResultAlcoTestView(
            alcoTestViewModel: AlcoTestViewModel())
    }
}

