//
//  AddAssignmentViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import UIKit

class AddAssignmentViewController: UIViewController {

    
    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var courseCodeTextField: UITextField!
    @IBOutlet weak var assignmentTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var dueTimeTextField: UITextField!
    @IBOutlet weak var dayNameTextField: UITextField!
    
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func addAssignmentButtonPressed(_ sender: UIButton) {
        let valid = AddAssignment(inputUsername: username, course_name: courseNameTextField.text ?? "", course_num: courseCodeTextField.text ?? "", assignmentName: assignmentTextField.text ?? "", dueDate: dueDateTextField.text ?? "", dueTime: dueTimeTextField.text ?? "", dayName: dayNameTextField.text ?? "")
        valid.getData {
            DispatchQueue.main.async {
                if valid.valid == "true" {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Error Adding Assignment", message: "Invalid Assignment")
                }
            }
        }
    }
    
}
