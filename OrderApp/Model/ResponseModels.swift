//
//  ResponseModels.swift
//  OrderApp
//
//  Created by Josue Cruz on 5/13/22.
//

import Foundation

struct CategoriesResponse: Codable {
    let categories: [String]
}

struct MenuResponse: Codable {
    let items: [MenuItem]
    
}

struct OrderResponse: Codable {
    let prepTime: Int
    
    enum CodingKeys: String, CodingKey {
        case prepTime = "preparation_time"
    }
}
