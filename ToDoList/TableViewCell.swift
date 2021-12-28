//
//  TableViewCell.swift
//  ToDoList
//
//  Created by Захар Князев on 26.12.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
   
    var item: ToDoItem!
    var itemIndex: Int!
    
    //ссылка на ViewController с основной таблицей
    var viewController: ViewController!
    
    @IBOutlet weak var viewParent: UIView!
    @IBOutlet weak var imageCheck: UIImageView!
    @IBOutlet weak var labelToDoText: UILabel!
    @IBOutlet weak var imageTrash: UIImageView!
    
    func initCell(item: ToDoItem, itemIndex: Int, viewController: ViewController) {
        self.item = item
        self.itemIndex = itemIndex
        self.viewController = viewController
        self.labelToDoText.text = item.text
        self.viewParent.transform = .identity
        setChecked()
        addTap()
        addPan()
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
    
    func addPan() {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(self.pan))
        pan.delegate = self
        viewParent.gestureRecognizers = [pan]
    }
    
    //var centerParentView: CGPoint!
    @objc
    func pan(pgr: UIPanGestureRecognizer) {
        /*if pgr.state == .began {
            centerParentView = viewParent.center
        }*/
        
        let dx = pgr.translation(in: viewParent).x
        //let newCenter = CGPoint(x: centerParentView.x + dx, y: centerParentView.y)
        
        //print(dx)
        if dx < 0 {
            contentView.backgroundColor = UIColor.red
        }else {
            contentView.backgroundColor = UIColor.orange
        }
        
        viewParent.transform = CGAffineTransform(translationX: dx, y: 0)
        //viewParent.center = newCenter
        
        //print(pgr.translation(in: viewParent))
        if pgr.state == .ended {
            //удаляем строку
            if dx < -60 {
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewParent.transform = CGAffineTransform(translationX: -500, y: 0)
                }) { (bool) in
                    self.viewController.deleteItem(itemIndex: self.itemIndex)
                }
                return
            }
            
            UIView.animate(withDuration: 0.2) {
                //self.viewParent.center = self.centerParentView
                self.viewParent.transform = .identity
            }
        }
    }
    
    //функция для распознавания жестов синхронно
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
}
