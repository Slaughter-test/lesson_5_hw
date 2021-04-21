//
//  ViewController.swift
//  lesson_5_hw
//
//  Created by Юрий Егоров on 20.04.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func addTask(_ sender: UIBarItem) {
        let alert = UIAlertController(title: "Task",
                                      message: "Create task",
                                      preferredStyle: UIAlertController.Style.alert)
        
        let textField = UITextField()
        textField.placeholder = "Insert the name of task"
        textField.keyboardType = .namePhonePad
        
        alert.addTextField { (textField) in
            textField.textColor = .blue
        }
        
        let action = UIAlertAction(title: "Add", style: .default) { [self] _  in
            let text = (alert.textFields?.first!.text)
            task.addSubtask(task: Subtask(name: text ?? "Task"))
            self.tableView.reloadData()
        }
        
        alert.addAction(action)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    var task: Subtask = Subtask(name: "Main task")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.navigationItem.title = task.name
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        vc.task = task.subtasks[indexPath.row]
        self.navigationController?.show(vc, sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        task.subtasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "TableViewCell")
        cell.textLabel?.text = task.subtasks[indexPath.row].name
        cell.detailTextLabel?.text = "\(task.subtasks[indexPath.row].subtasks.count)"
        return cell
    }
    
}

