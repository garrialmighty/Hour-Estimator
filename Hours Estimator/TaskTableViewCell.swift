//
//  TaskTableViewCell.swift
//  Hours Estimator
//
//  Created by Garri Adrian Nablo on 6/30/16.
//  Copyright © 2016 Knack Studios. All rights reserved.
//

import UIKit
import FontAwesome_swift

final class TaskTableViewCell: UITableViewCell {

    @IBOutlet weak var taskLabel: UILabel!
    @IBOutlet weak var arrowLabel: UILabel!
    @IBOutlet weak var addToEstimateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.arrowLabel.font = .fontAwesomeOfSize(20)
        self.arrowLabel.text = .fontAwesomeIconWithCode("fa-arrow-circle-right")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.contentView.backgroundColor = selected ? UIColor(red: 232/255, green: 68/255, blue: 59/255, alpha: 1.0) : UIColor(red: 0.0, green: 196/255, blue: 237/255, alpha: 1.0)
        self.addToEstimateView.backgroundColor = selected ? UIColor(red: 209/255, green: 61/255, blue: 53/255, alpha: 1.0) : UIColor(red: 0.0, green: 177/255, blue: 214/255, alpha: 1.0)
    }

}
