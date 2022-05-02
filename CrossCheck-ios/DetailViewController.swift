//
//  DetailViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/1/22.
//

import UIKit

class DetailViewController: UIViewController {

    
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var assignmentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var weekdayLabel: UILabel!
    
    var chosen_assignment: Assignment!
    var due_date: String = ""
    var chosen_class: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "\(due_date): \(chosen_class) "
        classLabel.text = chosen_class
        assignmentLabel.text = chosen_assignment.assignment_name
        dateLabel.text = due_date
        timeLabel.text = chosen_assignment.due_time
        weekdayLabel.text = chosen_assignment.day_name
    }

}
