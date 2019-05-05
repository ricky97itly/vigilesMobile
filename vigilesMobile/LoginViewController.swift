//
//  LoginViewController.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 21/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    var user = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterBtn.layer.cornerRadius = 15
        self.enterBtn.layer.borderWidth = 2.5
        self.enterBtn.layer.borderColor = UIColor.white.cgColor
        self.enterBtn.clipsToBounds = true
        self.email.layer.borderWidth = 2
        self.email.layer.cornerRadius = 15
        self.email.layer.borderColor = UIColor.white.cgColor
        self.password.layer.cornerRadius = 15
        self.password.layer.borderWidth = 2
        self.password.layer.borderColor = UIColor.white.cgColor
        
        UserModel().fetchEvents(complete: {
            (user) in self.user = user
        })
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        password.resignFirstResponder()
        return (true)
    }
    
    @IBAction func checkBox(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }
        else {
            sender.isSelected = true
        }
    }
    

    @IBAction func loginButton(_ sender: Any) {
        
    }
}
