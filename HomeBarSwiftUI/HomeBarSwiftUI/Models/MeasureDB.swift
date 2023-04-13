//
//  MeasureDB.swift
//  HomeBarSwiftUI
//
//  Created by Aleksandr Mayyura on 13.04.2023.
//

import Foundation

class MeasureDataStore {
    static let shared = MeasureDataStore()
    
    let measures = [
        "ml",
        "oz",
        "tsp",
        "tblsp",
        "dashes",
        "cube",
        "pieces",
        "splash"
    ]
    
    private init() {}
}
