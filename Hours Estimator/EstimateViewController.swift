//
//  EstimateViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 6/30/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

final class EstimateViewController: UIViewController {

    private let scrollContentView = UIView()
    private let viewModel: [String]!
    private var hourTextFields = [UITextField]()
    private var rateTextFields = [UITextField]()
    
    weak var delegate: TotalViewControllerDelegate?
    
    init(tasks: [String]) {
        self.viewModel = tasks
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Full Estimate"
        self.view.backgroundColor = .whiteColor()
        
        let scrollView = TPKeyboardAvoidingScrollView()
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
        
        let calculateButton = UIBarButtonItem(title: "Calculate", style: .Plain, target: self, action: #selector(EstimateViewController.didTapCalculate))
        self.navigationItem.rightBarButtonItem = calculateButton
        
        self.renderFields()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Private
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
                taskLabel.topAnchor.constraintEqualToAnchor(lastField.bottomAnchor, constant: 20.0).active = true
            } else {
                taskLabel.topAnchor.constraintEqualToAnchor(self.scrollContentView.topAnchor, constant: 20.0)
            }
            
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
            
            // keep track of variables
            lastField = hoursTextField
            self.hourTextFields.append(hoursTextField)
            self.rateTextFields.append(rateTextField)
        }
        
        lastField?.bottomAnchor.constraintEqualToAnchor(self.scrollContentView.bottomAnchor, constant: 250.0)
    }
    
    // MARK: Selector
    @objc private func didTapCalculate() {
        var totalHours = 0.0
        var totalPrice = 0.0
        
        for index in 0..<self.hourTextFields.count {
            if let hourString = self.hourTextFields[index].text,
                let rateString = self.rateTextFields[index].text,
                let hour = Double(hourString),
                let rate = Double(rateString) {
                totalHours += hour
                totalPrice += hour * rate
            } else {
                // handle error
            }
        }
        
        let totalViewController = TotalViewController(totalHours: totalHours, totalPrice: totalPrice)
        totalViewController.delegate = self.delegate
        self.navigationController?.pushViewController(totalViewController, animated: true)
    }
}
