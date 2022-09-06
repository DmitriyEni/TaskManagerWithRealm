//
//  SubtaskCell.swift
//  24_TableRealm
//
//  Created by Dmitriy Eni on 28.04.2022.
//

import UIKit

class SubtaskCell: UITableViewCell {

    @IBOutlet weak var subtaskLabel: UILabel!
    @IBOutlet weak var checkView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        
    }
    
    func setupCell(subtask: RealmSubtask) {
        checkView.backgroundColor = subtask.isDone ? .green : .white
        checkView.layer.borderColor = UIColor.green.cgColor
        checkView.layer.borderWidth = 1
        subtaskLabel.text = subtask.subtaskName
    }
}
