//
//  AddClassViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import UIKit

class AddClassViewController: UIViewController {


    @IBOutlet weak var courseNameTextField: UITextField!
    @IBOutlet weak var courseCodeTextField: UITextField!
    @IBOutlet weak var methodTextField: UITextField!
    
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
    
    @IBAction func addCourseButtonPressed(_ sender: UIButton) {
        
        let valid = AddCourse(inputUsername: username, course_name: courseNameTextField.text ?? "", course_num: courseCodeTextField.text ?? "", method: methodTextField.text ?? "")
        valid.getData {
            DispatchQueue.main.async {
                if valid.valid == "true" {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.showAlert(title: "Error Adding Course", message: "Invalid Course")
                }
            }
        }
    }
}
