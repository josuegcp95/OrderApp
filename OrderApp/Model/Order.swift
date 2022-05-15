//
//  Order.swift
//  OrderApp
//
//  Created by Josue Cruz on 5/13/22.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []){
        self.menuItems = menuItems
    }
}
