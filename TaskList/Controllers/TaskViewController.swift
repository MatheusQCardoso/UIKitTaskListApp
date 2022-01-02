//
//  TaskViewController.swift
//  TaskList
//
//  Created by Matheus Quirino on 01/01/22.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet var titleLabel: UITextView!
    @IBOutlet var descriptionLabel: UITextView!
    @IBOutlet var creationDateLabel: UITextView!
    
    private var deleted: Bool = false
    var taskIndex: Int?
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "trash"),
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(deleteTask))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
        fillData()
    }
    
    func fillData(){
        titleLabel.text = task?.titleText
        descriptionLabel.text = task?.descriptionText
        creationDateLabel.text = "Creation Date: \(task?.creationDate.formatted() ?? "")"
    }
    
    @objc func deleteTask(){
        guard let taskIndex = taskIndex, !deleted else {
            return
        }
        deleted = true

        let count = UserDefaults().integer(forKey: Constants.TASK_COUNT)
        let newCount = count - 1
        UserDefaults().set(newCount, forKey: Constants.TASK_COUNT)
        UserDefaults().removeObject(forKey: Constants.TASK_IDENTIFIER(taskIndex))
        UserDefaults().set(nil, forKey: Constants.TASK_IDENTIFIER(taskIndex))
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "main") as! ViewController
        navigationController?.popViewController(animated: true)
    }

}
