//
//  ClassViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/1/22.
//

import UIKit

class ClassViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var classAssignmentArray: [Assignment] = []
    var classes: [String] = []
    var due_date: String = ""
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = due_date
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowAssignment" {
            let destination = segue.destination as! AssignmentViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.chosen_class = classes[selectedIndexPath.row]
            destination.due_date = due_date
            destination.assignments = classAssignmentArray
            destination.username = username
            destination.password = password
        } else if segue.identifier == "AddCourse" {
            let destination = segue.destination as! UINavigationController
            let topDestination = destination.topViewController as! AddClassViewController
            topDestination.username = username
        }
    }
    

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "AddCourse", sender: sender)
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIBarButtonItem) {
        let assignments = Assignments(inputUsername: username, inputPassword: password)
        assignments.getData {
            DispatchQueue.main.async {
                self.classAssignmentArray = assignments.assignmentArray
                self.classes = assignments.uniqueClass
                self.tableView.reloadData()
            }
        }
    }
}

extension ClassViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return classes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let classCell = tableView.dequeueReusableCell(withIdentifier: "ClassCell", for: indexPath)
        var content = classCell.defaultContentConfiguration()
        content.text = classes[indexPath.row]
        classCell.contentConfiguration = content
        return classCell
    }
    
    
}
