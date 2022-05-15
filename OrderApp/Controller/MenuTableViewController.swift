//
//  MenuTableViewController.swift
//  OrderApp
//
//  Created by Josue Cruz on 5/13/22.
//

import UIKit

class MenuTableViewController: UITableViewController {
    
    let category: String
    var menuItems = [MenuItem]()
    
    init?(coder: NSCoder, category: String) {
        self.category = category
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = category.capitalized
        
        Task.init {
            do {
                let menuItems = try await MenuController.shared.fetchMenuItems(forCategory: category)
                updateUI(with: menuItems)
            } catch {
                displayError(error, title: "Failed to Fetch Menu Items for \(self.category)")
            }
        }
        
    }
    
    func updateUI(with menuItems: [MenuItem]) {
        self.menuItems = menuItems
        self.tableView.reloadData()
    }
    
    func displayError(_ error: Error, title: String) {
        guard let _ = viewIfLoaded?.window else { return }
        
        let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    // SHOW MENU ITEMS
    @IBSegueAction func showMenuItem(_ coder: NSCoder, sender: Any?) -> MenuItemDetailViewController? {
        guard let cell = sender as? UITableViewCell, let indexpath = tableView.indexPath(for: cell) else {
            return nil }
        
        let menuItem = menuItems[indexpath.row]
        return MenuItemDetailViewController(coder: coder, menuItem: menuItem)
    }
    
    // TABLE VIEW METHODS
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItem", for: indexPath)
        configureCell(cell, forCategoryAt: indexPath)
        return cell
    }
    
    func configureCell(_ cell: UITableViewCell, forCategoryAt indexPath: IndexPath) {
        let menuItem = menuItems[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = menuItem.name
        content.secondaryText = menuItem.price.formatted(.currency(code: "usd"))
        cell.contentConfiguration = content
    }
}
