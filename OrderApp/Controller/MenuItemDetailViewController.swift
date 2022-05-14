//
//  MenuItemDetailViewController.swift
//  OrderApp
//
//  Created by Josue Cruz on 5/13/22.
//

import UIKit

class MenuItemDetailViewController: UIViewController {
    let menuItem: MenuItem
    
    init?(coder: NSCoder, menuItem: MenuItem) {
        self.menuItem = menuItem
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
