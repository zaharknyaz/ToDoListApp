//
//  ViewController.swift
//  ToDoList
//
//  Created by Захар Князев on 23.12.2021.
//

import UIKit

class ToDoItem {
    var text: String
    var isCompleted: Bool
    init(text: String) {
        self.text = text
        self.isCompleted = false
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //сделать сохранение в памяти(в CoreData)
    var items: [ToDoItem] = [ToDoItem(text: "Сделал дело"), ToDoItem(text: "Гуляй смело")]
    
    //удаляем элемент
    func deleteItem(itemIndex: Int) {
        items.remove(at: itemIndex)
        tableView.deleteRows(at: [IndexPath(row: itemIndex, section: 0)], with: .automatic)
        
        //обновляем таблицу после удаления через 0.3 секунды
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3, execute: {
            self.tableView.reloadData()
        })
            
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: UIImageView!
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        cell.initCell(item: items[indexPath.row], itemIndex: indexPath.row, viewController: self)
        //устанавливаем текст ячейки со стилем(style) basic
        //cell.textLabel?.text = items[indexPath.row]
        return cell
    }
    
    func addItem() {
        let ac = UIAlertController(title: "", message: nil, preferredStyle: .alert)
        ac.addTextField { (textField) in
            textField.placeholder = "Enter new item"
        }
        
        let addButton = UIAlertAction(title: "Add", style: .default) { (alertAction) in
            if ac.textFields?[0].text != "" {
                self.items.insert(ToDoItem(text: ac.textFields?[0].text ?? ""), at: 0)
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

//добавление нового элемента
extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var y = scrollView.contentOffset.y
        if y < -100 {
            //можно сделать пружинную анимацию плюса перед тем как появится окно добавления элемента
            y = -100
        }
        
        if y < -20 {
            imageAdd.alpha = 1
            imageAdd.frame = CGRect(x: 0, y: 98, width: UIScreen.main.bounds.size.width, height: -y)
        }else {
            imageAdd.alpha = 0
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView.contentOffset.y < -100 {
            addItem()
        }
    }
}
