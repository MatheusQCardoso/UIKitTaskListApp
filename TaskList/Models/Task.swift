//
//  Task.swift
//  TaskList
//
//  Created by Matheus Quirino on 01/01/22.
//

import Foundation

enum EncodeTaskKeys: String{
    case titleText = "task_title"
    case descriptionText = "task_description"
    case creationDate = "task_creationdate"
}
 
class Task: NSObject, NSCoding{
    
    static func load(at index: Int) -> Task?{
        let decoded  = UserDefaults().object(forKey: Constants.TASK_IDENTIFIER(index))
        guard let decoded = decoded else {
            return nil
        }
        let task = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(decoded as! Data) as? Task
        
        return task
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.titleText, forKey: EncodeTaskKeys.titleText.rawValue)
        coder.encode(self.descriptionText, forKey: EncodeTaskKeys.descriptionText.rawValue)
        coder.encode(self.creationDate, forKey: EncodeTaskKeys.creationDate.rawValue)
    }
    
    required convenience init?(coder: NSCoder) {
        let titleText = coder.decodeObject(forKey: EncodeTaskKeys.titleText.rawValue) as! String
        let descriptionText = coder.decodeObject(forKey: EncodeTaskKeys.descriptionText.rawValue) as! String
        let creationDate = coder.decodeObject(forKey: EncodeTaskKeys.creationDate.rawValue) as! Date
        
        self.init(titleText: titleText,
                  descriptionText: descriptionText,
                  creationDate: creationDate)
    }
    
    init(titleText: String, descriptionText: String, creationDate: Date){
        self.titleText = titleText
        self.descriptionText = descriptionText
        self.creationDate = creationDate
    }
    
    var titleText: String = ""
    var descriptionText: String = ""
    var creationDate: Date = Date()
}
