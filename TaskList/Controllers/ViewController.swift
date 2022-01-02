//
//  ViewController.swift
//  TaskList
//
//  Created by Matheus Quirino on 01/01/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var tasks = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Tasks"
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapAddTask))
        
        navigationItem.rightBarButtonItem?.tintColor = .white
        
        if !UserDefaults().bool(forKey: Constants.DATA_SETUP){
            UserDefaults().set(true, forKey: Constants.DATA_SETUP)
            UserDefaults().set(0, forKey: Constants.TASK_COUNT)
        }else{
            let count = UserDefaults().integer(forKey: Constants.TASK_COUNT)
            for i in count+1...count+11 {
                guard Task.load(at: i) != nil else {
                    continue
                }
                print("ERR_ TRASH TASK FOUND, REMOVING")
                UserDefaults().removeObject(forKey: Constants.TASK_IDENTIFIER(i))
                UserDefaults().set(nil, forKey: Constants.TASK_IDENTIFIER(i))
            }
        }
        
        updateTasks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateTasks()
    }
    
    func updateTasks(){
        tasks.removeAll()
        let count = UserDefaults().integer(forKey: Constants.TASK_COUNT)
        
        for i in 0...count {
            let task = Task.load(at: i)
            guard let task = task else {
                continue
            }
            tasks.append(task)
        }
        tableView.reloadData()
    }

    @objc func didTapAddTask(){
        let vc = storyboard?.instantiateViewController(withIdentifier: "creation") as! CreationViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                print("ERR_ HERE")
                self.updateTasks()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "View Task"
        vc.task = tasks[indexPath.row]
        vc.taskIndex = indexPath.row
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].titleText
        return cell
    }
}

