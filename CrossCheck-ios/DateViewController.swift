//
//  DateViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 4/28/22.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
//    var assignments: Assignments!
    var assignments = Assignments()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.title = "CrossCheck"
        assignments.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowClass" {
            let destination = segue.destination as! ClassViewController
            destination.classes = self.assignments.uniqueClass
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.due_date = self.assignments.uniqueDateString[selectedIndexPath.row]
            destination.classAssignmentArray = self.assignments.assignmentArray
        }
    }

}
extension DateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.uniqueDateString.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
//        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)
        content.text = assignments.uniqueDateString[indexPath.row]
//        content.secondaryText = "second_text_here"
        cell.contentConfiguration = content
        return cell
    }
}
