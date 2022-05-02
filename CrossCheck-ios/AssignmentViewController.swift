//
//  AssignmentViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/1/22.
//

import UIKit

private let inputDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "y-MM-dd"
    return dateFormatter
} ()

private let outputDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd/y"
    return dateFormatter
} ()

class AssignmentViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var assignments: [Assignment] = []
    var due_date: String = ""
    var chosen_class: String = ""
    var chosen_assignments: [Assignment] = []
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "\(due_date): \(chosen_class) "
        var filter_date = ""
        if due_date == "No Due Date" {
            filter_date = ""
        } else {
            let temp_date = outputDateFormatter.date(from: due_date)!
            filter_date = inputDateFormatter.string(from: temp_date)
        }
        chosen_assignments = assignments.filter({$0.due_date == filter_date && $0.course_name == chosen_class})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! DetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.chosen_class = chosen_class
            destination.due_date = due_date
            destination.chosen_assignment = chosen_assignments[selectedIndexPath.row]
        } else if segue.identifier == "AddAssignment" {
            let destination = segue.destination as! UINavigationController
            let topDestination = destination.topViewController as! AddAssignmentViewController
            topDestination.username = username
        }
    }

    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        let new_assignments = Assignments(inputUsername: username, inputPassword: password)
        new_assignments.getData {
            DispatchQueue.main.async {
                self.assignments = new_assignments.assignmentArray
                var filter_date = ""
                if self.due_date == "No Due Date" {
                    filter_date = ""
                } else {
                    let temp_date = outputDateFormatter.date(from: self.due_date)!
                    filter_date = inputDateFormatter.string(from: temp_date)
                }
                self.chosen_assignments = self.assignments.filter({$0.due_date == filter_date && $0.course_name == self.chosen_class})
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddAssignment", sender: sender)
    }
    
}

extension AssignmentViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chosen_assignments.count == 0 {
            return 1
        }
        return chosen_assignments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        for no assignments due button
        if chosen_assignments.count == 0 {
            let assignmentCell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
            var content = assignmentCell.defaultContentConfiguration()
            content.text = "NO ASSIGNMENTS DUE"
            assignmentCell.contentConfiguration = content
            tableView.allowsSelection = false
            return assignmentCell
        }
        let assignmentCell = tableView.dequeueReusableCell(withIdentifier: "AssignmentCell", for: indexPath)
        var content = assignmentCell.defaultContentConfiguration()
        content.text = chosen_assignments[indexPath.row].assignment_name
        assignmentCell.contentConfiguration = content
        return assignmentCell
    }
    
    
}
