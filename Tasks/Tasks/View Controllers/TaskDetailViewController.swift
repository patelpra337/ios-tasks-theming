//
//  TaskDetailViewController.swift
//  Tasks
//
//  Created by Andrew R Madsen on 8/11/18.
//  Copyright © 2018 Andrew R Madsen. All rights reserved.
//

import UIKit

class TaskDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
    }

    @IBAction func save(_ sender: Any) {
        guard let name = nameTextField.text, !name.isEmpty else {
            return
        }
        
        let priorityIndex = priorityControl.selectedSegmentIndex
        let priority = TaskPriority.allPriorities[priorityIndex]
        let notes = notesTextView.text
        
        if let task = task {
            // Editing existing task
            taskController.update(task: task, with: name, notes: notes, priority: priority)
        } else {
            taskController.createTask(with: name, notes: notes, priority: priority)
        }

        navigationController?.popViewController(animated: true)
    }
    
    private func setupAppearances() {
        self.nameTextField.backgroundColor = AppearanceHelper.backgroundGray
        self.nameTextField.textColor = .white
        self.nameTextField.layer.borderColor = UIColor.white.cgColor
        self.nameTextField.layer.borderWidth = 0.5
        self.nameTextField.layer.cornerRadius = 8.0
        self.nameTextField.font = AppearanceHelper.typerighterFont(with: .body, pointSize: 28)
        self.nameTextField.keyboardAppearance = .dark
        
        self.view.backgroundColor = AppearanceHelper.backgroundGray
        
    }
    private func updateViews() {
        guard isViewLoaded else { return }
                
        title = task?.name ?? "Create Task"
        nameTextField.text = task?.name
        let priority: TaskPriority
        if let taskPriority = task?.priority {
            priority = TaskPriority(rawValue: taskPriority)!
        } else {
            priority = .normal
        }
        priorityControl.selectedSegmentIndex = TaskPriority.allPriorities.firstIndex(of: priority)!
        notesTextView.text = task?.notes
    }
    
    // MARK: Properties
    
    var task: Task? {
        didSet {
            updateViews()
        }
    }
    
    var taskController: TaskController!

    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var priorityControl: UISegmentedControl!
    @IBOutlet var notesTextView: UITextView!
}
