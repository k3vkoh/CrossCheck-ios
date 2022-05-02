//
//  LoginViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/1/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        if segue.identifier == "ShowDate"  {
            let destination = segue.destination as! UINavigationController
            let topDestination = destination.topViewController as! DateViewController
            topDestination.assignments = Assignments(inputUsername: usernameTextField.text ?? "", inputPassword: passwordTextField.text ?? "")
            topDestination.username = usernameTextField.text ?? ""
            topDestination.password = passwordTextField.text ?? ""
        }        
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        let valid = Login(inputUsername: usernameTextField.text ?? "", inputPassword: passwordTextField.text ?? "")
        valid.getData {
            DispatchQueue.main.async {
                if valid.valid == "true" {
                    self.performSegue(withIdentifier: "ShowDate", sender: sender)
                } else {
                    self.showAlert(title: "Login Error", message: "Invalid Username/Password")
                }
            }
        }
    }
}
