//
//  SubtaskController.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import UIKit

class SubtaskController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var subtasks = [RealmSubtask]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var task: RealmTask?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: SubtaskCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SubtaskCell.self))
        guard let task = task else {
            return
        }
        
        subtasks = RealmManager.read(type: RealmSubtask.self).filter({$0.ownerID == task.id})
    }


    @IBAction func saveButton(_ sender: Any) {
        let vc = AddController(nibName: String(describing: AddController.self), bundle: nil)
        vc.type = .subtask
        vc.task = self.task
        vc.saveBlack = {
            guard let task = self.task else {
                return
            }
            self.subtasks = RealmManager.read(type: RealmSubtask.self).filter({$0.ownerID == task.id})
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

extension SubtaskController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return subtasks.filter({ !$0.isDone }).count
        }
        return subtasks.filter({ $0.isDone }).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let subtaskCell = tableView.dequeueReusableCell(withIdentifier: String(describing: SubtaskCell.self), for: indexPath) as! SubtaskCell
        if indexPath.section == 0 {
            let undone = subtasks.filter({ !$0.isDone })
            subtaskCell.setupCell(subtask: undone[indexPath.row])
        } else if indexPath.section == 1 {
            let done = subtasks.filter({ $0.isDone })
            subtaskCell.setupCell(subtask: done[indexPath.row])
            
            }
        
        return subtaskCell
    }
}

extension SubtaskController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        RealmManager.startTransaction()
        if indexPath.section == 0 {
            let undone = subtasks.filter({ !$0.isDone })
            undone[indexPath.row].isDone = !undone[indexPath.row].isDone
        } else if indexPath.section == 1 {
            let done = subtasks.filter({ $0.isDone })
            done[indexPath.row].isDone = !done[indexPath.row].isDone
        }
//        subtasks[indexPath.row].isDone = !subtasks[indexPath.row].isDone
        RealmManager.closeTransaction()
//        tableView.reloadRows(at: [indexPath], with: .automatic)
        tableView.reloadData()
    }
   
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Невыполненные:"
        }
        return "Выполненные:"
    }
    
}

