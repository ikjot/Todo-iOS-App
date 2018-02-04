//
//  ViewController.swift
//  ToDoList
//
//  Created by Ikjot Kaur on 2/2/18.
//  Copyright © 2018 Ikjot Kaur. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var todoListTableView: UITableView!
    var todos : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "My ToDo List"
        self.todoListTableView.register(UITableViewCell.self, forCellReuseIdentifier: "ToDoCell")
    }

    @IBAction func AddItemClicked(_ sender: Any) {
    }
    
    //MARK :- TableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.todoListTableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = self.todos[indexPath.row]
        return cell
    }
}

