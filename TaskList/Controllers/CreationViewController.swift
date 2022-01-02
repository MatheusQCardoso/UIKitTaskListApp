//
//  CreationViewController.swift
//  TaskList
//
//  Created by Matheus Quirino on 01/01/22.
//

import UIKit

class CreationViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var descriptionTextField: UITextView!
    
    var update: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.tintColor = .white
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        saveTask()
        
        return true
    }
    
    @IBAction func saveTask(){
        guard let titleText = titleTextField.text, !titleText.isEmpty else{
            return
        }
        guard let descriptionText = descriptionTextField.text, !descriptionText.isEmpty else{
            return
        }
        let taskCount = UserDefaults().integer(forKey: Constants.TASK_COUNT)
        let nextIndex = taskCount + 1
        let newTask = Task(titleText: titleText, descriptionText: descriptionText, creationDate: Date())
        do{
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: newTask,
                                                               requiringSecureCoding: false)
            UserDefaults().set(encodedData,
                               forKey: Constants.TASK_IDENTIFIER(nextIndex))
            UserDefaults().set(nextIndex, forKey: Constants.TASK_COUNT)
            
            let newIdentifier = Constants.TASK_IDENTIFIER( nextIndex )
            print("ERR_ INSERTED AT \(newIdentifier)")
            update?()
            navigationController?.popViewController(animated: true)
        }
        catch{
            print("ERR_ \(error.localizedDescription)")
            let alert = UIAlertController(title: "Error!",
                                          message: error.localizedDescription,
                                          preferredStyle: .alert)
            alert.view.frame = view.bounds
            navigationController?.pushViewController(alert, animated: false)
        }
    }

}
