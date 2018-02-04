//
//  ViewController.swift
//  ToDoList
//
//  Created by Ikjot Kaur on 2/2/18.
//  Copyright © 2018 Ikjot Kaur. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var todoListTableView: UITableView!
    var todos : [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My ToDo List"
        self.todoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let applicationDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedObjectContext = applicationDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Todo")
        
        do {
            todos = try managedObjectContext.fetch(fetchRequest)
        } catch _ as NSError {
        }
    }

    @IBAction func AddItemClicked(_ sender: Any) {
        let addTodoBoxAlert = UIAlertController(title: "New Todo", message: "Got a new job to be done? Enter it here", preferredStyle: UIAlertControllerStyle.alert)
        let saveTodoAction = UIAlertAction(title: "Add", style: UIAlertActionStyle.default) { (action) in
            if let textField = addTodoBoxAlert.textFields?.first {
                if let todoItem = textField.text {
                    self.persistTodo(todoStr: todoItem)
                    self.todoListTableView.reloadData()
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default) { (_) in
            
        }
        
        addTodoBoxAlert.addTextField { (_) in
            
        }
        addTodoBoxAlert.addAction(saveTodoAction)
        addTodoBoxAlert.addAction(cancelAction)
        
        present(addTodoBoxAlert, animated: true) {
            
        }

    }
    
    func persistTodo(todoStr : String) {
        guard let appDelegate : AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedObjectContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Todo", in: managedObjectContext)!
        let todo = NSManagedObject(entity: entity, insertInto: managedObjectContext)
        todo.setValue(todoStr, forKeyPath: "item")
        do {
            try managedObjectContext.save()
            todos.append(todo)
        } catch _ as NSError {
            
        }
    
        
        
    }
    
    //MARK :- TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.todoListTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        
        cell.textLabel?.text = self.todos[indexPath.row].value(forKeyPath: "item") as? String
        return cell
    }
}

