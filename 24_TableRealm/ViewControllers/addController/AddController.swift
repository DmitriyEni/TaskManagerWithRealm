//
//  AddController.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import UIKit

enum AddType {
    case task
    case subtask
    
    var placeholder: String {
        switch self {
        case .task:
            return "Название списка"
        case .subtask:
            return "Задача"
        }
    }
}

class AddController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var inputField: UITextField!
    
    var saveBlack: (() -> ())?
    var type = AddType.task
    var task: RealmTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.layer.cornerRadius = 16
        inputField.placeholder = type.placeholder
    }

    @IBAction func saveAction(_ sender: Any) {
        guard let text = inputField.text else {return}
        
        switch type {
        case .task:
            RealmManager.write(object: RealmTask(taskName: text))
        case .subtask:
            guard let task = task else {
                return
            }
            RealmManager.write(object: RealmSubtask(ownerID: task.id, subtaskName: text))
        }
        
        saveBlack?()
        dismiss(animated: true)
    }
}
