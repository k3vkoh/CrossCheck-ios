//
//  SetInfoViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/2/22.
//

import UIKit

class SetInfoViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var canvasUsernameTextField: UITextField!
    @IBOutlet weak var canvasPasswordTextField: UITextField!
    
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
        if segue.identifier == "ShowClassSetup"  {
            let destination = segue.destination as! SetClassViewController
            destination.username = usernameTextField.text ?? ""
            destination.password = passwordTextField.text ?? ""
        }
    }
    
    @IBAction func nextButtonPressed(_ sender: UIButton) {
        let valid = Signup(inputUsername: usernameTextField.text ?? "", inputPassword: passwordTextField.text ?? "", canvasUsername: canvasUsernameTextField.text ?? "", canvasPassword: canvasPasswordTextField.text ?? "")
        valid.getData {
            DispatchQueue.main.async {
                if valid.valid == "true" {
                    self.performSegue(withIdentifier: "ShowClassSetup", sender: sender)
                } else {
                    self.showAlert(title: "Signup Error", message: "Signup Failed!")
                }
            }
        }
    }
}
