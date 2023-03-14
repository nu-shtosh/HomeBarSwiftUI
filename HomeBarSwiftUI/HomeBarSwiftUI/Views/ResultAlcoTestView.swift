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
        Text(alcoTestViewModel.motivatingText)
            .onAppear {
                alcoTestViewModel.loadData()
                
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Result")
    }
        
}

struct ResultAlcoTestView_Previews: PreviewProvider {
    static var previews: some View {
        ResultAlcoTestView(alcoTestViewModel: AlcoTestViewModel())
    }
}

