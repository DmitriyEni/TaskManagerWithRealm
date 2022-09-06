//
//  TaskController.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import UIKit

class TaskController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var tasks = RealmManager.read(type: RealmTask.self) {
        didSet {
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: TaskCell.self), bundle: nil), forCellReuseIdentifier: String(describing: TaskCell.self))

    }
    @IBAction func addTaskAction(_ sender: Any) {
        let vc = AddController(nibName: String(describing: AddController.self), bundle: nil)
        vc.type = .task
        vc.saveBlack = {
            
            self.tasks = RealmManager.read(type: RealmTask.self)
        }
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}

extension TaskController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let taskCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as! TaskCell
        taskCell.taskLabel.text = tasks[indexPath.row].taskName
        return taskCell

    }
}

extension TaskController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = SubtaskController(nibName: String(describing: SubtaskController.self), bundle: nil)
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
