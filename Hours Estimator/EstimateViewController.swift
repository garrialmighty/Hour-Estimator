//
//  EstimateViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 6/30/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit

final class EstimateViewController: UIViewController {

    let scrollContentView = UIView()
    var viewModel = [String]()
    
    convenience init(tasks: [String]) {
        self.init(nibName: nil, bundle: nil)
        self.viewModel = tasks
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = .whiteColor()
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(scrollView)
        NSLayoutConstraint.activateConstraints([
            scrollView.topAnchor.constraintEqualToAnchor(self.view.topAnchor),
            scrollView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor),
            scrollView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
            scrollView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor),
            ])
        
        self.scrollContentView.backgroundColor = .whiteColor()
        self.scrollContentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(self.scrollContentView)
        NSLayoutConstraint.activateConstraints([
            self.scrollContentView.topAnchor.constraintEqualToAnchor(scrollView.topAnchor),
            self.scrollContentView.bottomAnchor.constraintEqualToAnchor(scrollView.bottomAnchor),
            self.scrollContentView.leadingAnchor.constraintEqualToAnchor(scrollView.leadingAnchor),
            self.scrollContentView.trailingAnchor.constraintEqualToAnchor(scrollView.trailingAnchor),
            self.scrollContentView.centerXAnchor.constraintEqualToAnchor(scrollView.centerXAnchor),
            self.scrollContentView.centerYAnchor.constraintEqualToAnchor(scrollView.centerYAnchor)
            ])
        
        self.renderFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func renderFields() {
        var lastField: UIView?
        
        for taskName in self.viewModel {
            let taskLabel = UILabel()
            taskLabel.text = taskName
            taskLabel.numberOfLines = 0
            taskLabel.translatesAutoresizingMaskIntoConstraints = false
            self.scrollContentView.addSubview(taskLabel)
            taskLabel.leadingAnchor.constraintEqualToAnchor(self.scrollContentView.leadingAnchor, constant: 5.0).active = true
            
            if let lastField = lastField {
                taskLabel.topAnchor.constraintEqualToAnchor(lastField.bottomAnchor, constant: 10.0).active = true
            } else {
                taskLabel.topAnchor.constraintEqualToAnchor(self.scrollContentView.topAnchor, constant: 10.0)
            }
            
            lastField = taskLabel
            
            let hoursTextField = UITextField()
            hoursTextField.placeholder = "Hours"
            hoursTextField.keyboardType = .DecimalPad
            hoursTextField.borderStyle = .RoundedRect
            hoursTextField.font = .systemFontOfSize(12.0)
            hoursTextField.translatesAutoresizingMaskIntoConstraints = false
            self.scrollContentView.addSubview(hoursTextField)
            NSLayoutConstraint.activateConstraints([
                hoursTextField.centerYAnchor.constraintEqualToAnchor(taskLabel.centerYAnchor),
                hoursTextField.leadingAnchor.constraintEqualToAnchor(taskLabel.trailingAnchor)
                ])

            let rateTextField = UITextField()
            rateTextField.placeholder = "Price per hour"
            rateTextField.keyboardType = .DecimalPad
            rateTextField.borderStyle = .RoundedRect
            rateTextField.font = .systemFontOfSize(12.0)
            rateTextField.translatesAutoresizingMaskIntoConstraints = false
            self.scrollContentView.addSubview(rateTextField)
            NSLayoutConstraint.activateConstraints([
                rateTextField.centerYAnchor.constraintEqualToAnchor(taskLabel.centerYAnchor),
                rateTextField.leadingAnchor.constraintEqualToAnchor(hoursTextField.trailingAnchor, constant: 5.0),
                rateTextField.trailingAnchor.constraintEqualToAnchor(self.scrollContentView.trailingAnchor, constant: -5.0)
                ])
            
            // make all fields have equal width
            NSLayoutConstraint.activateConstraints([
                taskLabel.widthAnchor.constraintEqualToAnchor(hoursTextField.widthAnchor),
                hoursTextField.widthAnchor.constraintEqualToAnchor(rateTextField.widthAnchor)
                ])
        }
    }
}
