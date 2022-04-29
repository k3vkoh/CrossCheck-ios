//
//  DateViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 4/28/22.
//

import UIKit

class DateViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var assignments = Assignments()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        assignments.getData {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }


}
extension DateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assignments.assignmentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DateCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
//        content.textProperties.font = UIFont.preferredFont(forTextStyle: .title1)
        content.text = assignments.assignmentArray[indexPath.row].due_date
//        content.secondaryText = "second_text_here"
        cell.contentConfiguration = content
        return cell
    }
    
    
}

