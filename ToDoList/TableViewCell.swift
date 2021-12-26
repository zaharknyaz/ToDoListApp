//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Захар Князев on 26.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
   
    var item: ToDoItem!
    
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelToDoText: UILabel!
    
    func initCell(item: ToDoItem) {
        self.item = item
        self.labelToDoText.text = item.text
        setChecked()
        addTap()
    }
        
    func setChecked() {
        if item.isCompleted {
            imageCheck.image = UIImage(systemName: "checkmark.circle")
        }else {
            imageCheck.image = UIImage(systemName: "circle")
        }
    }
    
    func addTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tap))
        imageCheck?.gestureRecognizers = [tap]
    }
    
    @objc
    func tap() {
        item.isCompleted = !item.isCompleted
        setChecked()
        UIView.animate(withDuration: 0.2) {
            self.imageCheck.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: {(bool) in
            self.imageCheck.transform = .identity
        }

    }
}
