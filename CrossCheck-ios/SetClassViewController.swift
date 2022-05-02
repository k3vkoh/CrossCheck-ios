//
//  ViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import UIKit

class SetClassViewController: UIViewController {

    @IBOutlet weak var classTextView: UITextView!
    
    var username = ""
    var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDateSignup"  {
            let destination = segue.destination as! UINavigationController
            let topDestination = destination.topViewController as! DateViewController
            topDestination.assignments = Assignments(inputUsername: username, inputPassword: password)
            topDestination.username = username
            topDestination.password = password
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        let valid = Setup(inputUsername: username, course_string: classTextView.text)
        valid.getData {
            DispatchQueue.main.async {
                if valid.valid == "true" {
                    self.performSegue(withIdentifier: "ShowDateSignup", sender: sender)
                } else {
                    self.showAlert(title: "Class Setup Error", message: "Class Setup Failed!")
                }
            }
        }
    }
}
