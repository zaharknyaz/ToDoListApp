//
//  ViewController.swift
//  ToDoList
//
//  Created by Захар Князев on 23.12.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //сделать сохранение в памяти(в CoreData)
    var items: [String] = ["to do item 1", "to do item 2", "to do item 3"]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }

    override func viewDidAppear(_ animated: Bool) {
        //вызов добавления элемента при появлении view
        //addItem()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func addItem() {
        let ac = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter new item"
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            if ac.textFields?[0].text != "" {
                self.items.insert(ac.textFields?[0].text ?? "", at: 0)
                //перезагрузить таблицу
                //self.tableView.reloadData()
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
                
            }
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        ac.addAction(addButton)
        ac.addAction(cancelButton)
        
        present(ac, animated: true, completion: nil)
    }
    
}

