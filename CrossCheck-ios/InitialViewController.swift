//
//  InitialViewController.swift
//  CrossCheck-ios
//
//  Created by Chino on 5/1/22.
//

import UIKit

class InitialViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func signupPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowSignUp", sender: sender)
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowLogin", sender: sender)
    }
    
    
}
