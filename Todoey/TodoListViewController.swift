//
//  ViewController.swift
//  Todoey
//
//  Created by Aleksandr Shelestov on 10/1/18.
//  Copyright © 2018 Aleksandr Shelestov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    var itemArray : [Item] = []
    
    let defaults = UserDefaults.standard
    
//    var itemArray = defaults.get(key: "TodoListArray")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.title = "Alex - 1"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Alex - 2"
        newItem2.done = true
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Alex - 3"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
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
        
        cell.textLabel?.text = item.title
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    // MARK — TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = itemArray[indexPath.row]
        
        item.done = !item.done
        self.saveData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK — Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "My Alert", message: nil, preferredStyle: .alert)
        let addItemAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "Just to cancel it"), style: .cancel, handler: nil)
        let cancelAction = UIAlertAction(title: NSLocalizedString("Add Item", comment: "Default action"), style: .default, handler: { _ in
            if let name = textField.text {
                
                let newItem = Item()
                newItem.title = name
                
                self.itemArray.append(newItem)
                
                self.saveData()
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
    
    func saveData() {
        self.defaults.set(self.itemArray, forKey: "TodoListArray")
        tableView.reloadData()
    }
    
}

