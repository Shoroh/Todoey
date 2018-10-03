//
//  ViewController.swift
//  Todoey
//
//  Created by Aleksandr Shelestov on 10/1/18.
//  Copyright © 2018 Aleksandr Shelestov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray = ["Find Mike", "Buy Egos", "Destroy Demogorgon"];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // MARK — TableView Datasource Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ToDoItemCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item
        
        return cell
    }
    
    // MARK — TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        let accessoryType = cell?.accessoryType
        
        if accessoryType == .checkmark {
            cell?.accessoryType = .none
        } else {
            cell?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK — Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "My Alert", message: nil, preferredStyle: .alert)
        let addItemAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Just to cancel it"), style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Add Item", comment: "Default action"), style: .default, handler: { _ in
            if let name = textField.text {
                self.itemArray.append(name)
                self.tableView.reloadData()
            }
        })
        
        alert.addAction(addItemAction)
        alert.addAction(cancelAction)
        
        alert.addTextField(
            configurationHandler: {
                alertTextField in
                alertTextField.placeholder = "Input a todo name here..."
                textField = alertTextField
            }
        )
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

