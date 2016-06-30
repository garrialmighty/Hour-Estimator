//
//  ViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 6/30/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit

final class TasksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = [["Planning": ["Inception Deck", "Market Research", "Stakeholder Interview"]],
                     ["Design": ["Wireframing", "Mockups", "Flow User Testing", "Style Guide", "Brand Analysis"]],
                     ["Development": ["Setup and Scaffolding"]]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didTapNext(sender: AnyObject) {
        print(self.tableView.indexPathsForSelectedRows)
    }
}

extension TasksViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.viewModel.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tasks = self.viewModel[section].values.first else { return 0 }
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("TaskCell", forIndexPath: indexPath) as? TaskTableViewCell,
            let tasks = self.viewModel[indexPath.section].values.first
            else { return TaskTableViewCell() }
        
        cell.taskLabel.text = tasks[indexPath.item]
        
        return cell
    }
}

extension TasksViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel[section].keys.first
    }
}

