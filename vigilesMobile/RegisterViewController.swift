//
//  RegisterViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 20/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var surname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var repeatPassword: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerBtn.layer.cornerRadius = 15
        self.registerBtn.layer.borderWidth = 2.5
        self.registerBtn.layer.borderColor = UIColor.white.cgColor
        self.registerBtn.clipsToBounds = true
        self.registerBtn.layer.cornerRadius = 15
        self.name.layer.borderWidth = 2
        self.name.layer.cornerRadius = 15
        self.name.layer.borderColor = UIColor.white.cgColor
        self.surname.layer.borderWidth = 2
        self.surname.layer.cornerRadius = 15
        self.surname.layer.borderColor = UIColor.white.cgColor
        self.email.layer.borderWidth = 2
        self.email.layer.cornerRadius = 15
        self.email.layer.borderColor = UIColor.white.cgColor
        self.password.layer.borderWidth = 2
        self.password.layer.cornerRadius = 15
        self.password.layer.borderColor = UIColor.white.cgColor
        self.repeatPassword.layer.borderWidth = 2
        self.repeatPassword.layer.cornerRadius = 15
        self.repeatPassword.layer.borderColor = UIColor.white.cgColor
       
        // Do any additional setup after loading the view.
    }

}
