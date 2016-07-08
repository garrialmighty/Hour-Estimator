//
//  ViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 6/30/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import MGSwipeTableCell

final class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    
    private let viewModel = TasksViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func didTapNext(sender: AnyObject) {
        if let selectedIndexPaths = self.tableView.indexPathsForSelectedRows {
            var taskNames = [String]()
            for indexPath in selectedIndexPaths {
                guard let tasks = self.viewModel.tasks[indexPath.section].values.first else { continue }
                taskNames.append(tasks[indexPath.item].name)
            }
            
            let estimateViewController = EstimateViewController(tasks: taskNames)
            estimateViewController.delegate = self
            self.navigationController?.pushViewController(estimateViewController, animated: true)
        }
    }
    
    @IBAction func didTapAdd(sender: AnyObject) {
        let addTaskViewController = AddTaskViewController()
        addTaskViewController.delegate = self
        self.presentViewController(AddTaskViewController(), animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension TasksViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel.tasks.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = self.viewModel.tasks[section].values.first else { return 0 }
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as? TaskTableViewCell,
            let tasks = self.viewModel.tasks[indexPath.section].values.first
            else { return TaskTableViewCell() }
        
        cell.taskLabel.text = tasks[indexPath.item]
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TasksViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.tasks[section].keys.first
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.nextButton.enabled = true
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        self.nextButton.enabled = tableView.indexPathsForSelectedRows?.count > 0
    }
}

// MARK: - TotalViewControllerDelegate
extension TasksViewController: TotalViewControllerDelegate {
    func totalViewControllerWillReset(viewController: TotalViewController) {
        guard let selectedIndexPaths = self.tableView.indexPathsForSelectedRows else { return }
        
        for indexpath in selectedIndexPaths {
            self.tableView.deselectRowAtIndexPath(indexpath, animated: false)
        }
        
        let firstIndexPath = NSIndexPath(forItem: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(firstIndexPath, atScrollPosition: .Top, animated: false)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
}

