//
//  TotalViewController.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 7/1/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import FontAwesome_swift

protocol TotalViewControllerDelegate: class {
    func totalViewControllerWillReset(viewController: TotalViewController)
}

final class TotalViewController: UIViewController {

    private let totalHours: Double!
    private let totalPrice: Double!
    
    weak var delegate: TotalViewControllerDelegate?
    
    init(totalHours: Double, totalPrice: Double) {
        self.totalHours = totalHours
        self.totalPrice = totalPrice
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let hoursContentView = UIView()
        hoursContentView.translatesAutoresizingMaskIntoConstraints = false
        hoursContentView.backgroundColor = UIColor(red: 254/255, green: 151/255, blue: 44/255, alpha: 1.0)
        self.view.addSubview(hoursContentView)
        NSLayoutConstraint.activateConstraints([
            hoursContentView.topAnchor.constraintEqualToAnchor(self.view.topAnchor),
            hoursContentView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
            hoursContentView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor)
            ])
        
        let clockLabel = UILabel()
        clockLabel.textColor = .whiteColor()
        clockLabel.font = .fontAwesomeOfSize(120)
        clockLabel.text = .fontAwesomeIconWithCode("fa-clock-o")
        clockLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursContentView.addSubview(clockLabel)
        NSLayoutConstraint.activateConstraints([
            clockLabel.centerYAnchor.constraintEqualToAnchor(hoursContentView.centerYAnchor),
            clockLabel.leadingAnchor.constraintEqualToAnchor(hoursContentView.leadingAnchor, constant: 30.0)
            ])
        
        let totalHoursLabel = UILabel()
        totalHoursLabel.text = "\(totalHours)"
        totalHoursLabel.textColor = .whiteColor()
        totalHoursLabel.font = UIFont.boldSystemFontOfSize(30.0)
        totalHoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursContentView.addSubview(totalHoursLabel)
        NSLayoutConstraint.activateConstraints([
            totalHoursLabel.centerYAnchor.constraintEqualToAnchor(clockLabel.centerYAnchor),
            totalHoursLabel.leadingAnchor.constraintEqualToAnchor(clockLabel.trailingAnchor, constant: 20.0)
            ])
        
        let hoursLabel = UILabel()
        hoursLabel.text = "TOTAL HOURS"
        hoursLabel.textColor = .whiteColor()
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursContentView.addSubview(hoursLabel)
        NSLayoutConstraint.activateConstraints([
            hoursLabel.leadingAnchor.constraintEqualToAnchor(totalHoursLabel.leadingAnchor),
            hoursLabel.bottomAnchor.constraintEqualToAnchor(totalHoursLabel.topAnchor, constant: -10.0)
            ])
        
        let priceContentView = UIView()
        priceContentView.translatesAutoresizingMaskIntoConstraints = false
        priceContentView.backgroundColor = UIColor(red: 0.0, green: 165/255, blue: 96/255, alpha: 1.0)
        self.view.addSubview(priceContentView)
        NSLayoutConstraint.activateConstraints([
            priceContentView.leadingAnchor.constraintEqualToAnchor(self.view.leadingAnchor),
            priceContentView.trailingAnchor.constraintEqualToAnchor(self.view.trailingAnchor),
            priceContentView.topAnchor.constraintEqualToAnchor(hoursContentView.bottomAnchor),
            priceContentView.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor)
            ])
        
        let moneyLabel = UILabel()
        moneyLabel.textColor = .whiteColor()
        moneyLabel.font = .fontAwesomeOfSize(100)
        moneyLabel.text = .fontAwesomeIconWithCode("fa-money")
        moneyLabel.translatesAutoresizingMaskIntoConstraints = false
        priceContentView.addSubview(moneyLabel)
        NSLayoutConstraint.activateConstraints([
            moneyLabel.centerYAnchor.constraintEqualToAnchor(priceContentView.centerYAnchor),
            moneyLabel.leadingAnchor.constraintEqualToAnchor(priceContentView.leadingAnchor, constant: 30.0)
            ])
        
        let totalPriceLabel = UILabel()
        totalPriceLabel.text = "$\(totalPrice)"
        totalPriceLabel.textColor = .whiteColor()
        totalPriceLabel.font = .boldSystemFontOfSize(30.0)
        totalPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceContentView.addSubview(totalPriceLabel)
        NSLayoutConstraint.activateConstraints([
            totalPriceLabel.centerYAnchor.constraintEqualToAnchor(priceContentView.centerYAnchor),
            totalPriceLabel.leadingAnchor.constraintEqualToAnchor(moneyLabel.trailingAnchor, constant: 20.0)
            ])
        
        let priceLabel = UILabel()
        priceLabel.text = "ESTIMATED PRICE"
        priceLabel.textColor = .whiteColor()
        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        priceContentView.addSubview(priceLabel)
        NSLayoutConstraint.activateConstraints([
            priceLabel.leadingAnchor.constraintEqualToAnchor(totalPriceLabel.leadingAnchor),
            priceLabel.bottomAnchor.constraintEqualToAnchor(totalPriceLabel.topAnchor, constant: -10.0)
            ])
        
        // make both content views have the same height
        hoursContentView.heightAnchor.constraintEqualToAnchor(priceContentView.heightAnchor).active = true
        
        let resetButton = UIBarButtonItem(title: "Reset", style: .Plain, target: self, action: #selector(TotalViewController.didTapReset))
        self.navigationItem.rightBarButtonItem = resetButton
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Selector
    @objc private func didTapReset() {
        self.delegate?.totalViewControllerWillReset(self)
    }
}
