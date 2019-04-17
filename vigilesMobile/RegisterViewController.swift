//
//  RegisterViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 20/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var address: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn.layer.cornerRadius = 15
        self.registerBtn.layer.borderWidth = 1
        self.registerBtn.layer.borderColor = UIColor.white.cgColor
        self.registerBtn.clipsToBounds = true
        self.name.layer.borderWidth = 1
        self.name.layer.cornerRadius = 15
        self.name.layer.borderColor = UIColor.white.cgColor
        self.surname.layer.borderWidth = 1
        self.surname.layer.cornerRadius = 15
        self.surname.layer.borderColor = UIColor.white.cgColor
        self.email.layer.borderWidth = 1
        self.email.layer.cornerRadius = 15
        self.email.layer.borderColor = UIColor.white.cgColor
        self.password.layer.borderWidth = 1
        self.password.layer.cornerRadius = 15
        self.password.layer.borderColor = UIColor.white.cgColor
        self.repeatPassword.layer.borderWidth = 1
        self.repeatPassword.layer.cornerRadius = 15
        self.repeatPassword.layer.borderColor = UIColor.white.cgColor
        self.address.layer.borderWidth = 1
        self.address.layer.cornerRadius = 15
        self.address.layer.borderColor = UIColor.white.cgColor
       
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // hide keyboard when I press return
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        surname.resignFirstResponder()
        email.resignFirstResponder()
        password.resignFirstResponder()
        repeatPassword.resignFirstResponder()
        return (true)
    }
}
