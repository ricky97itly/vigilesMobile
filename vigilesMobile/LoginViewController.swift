//
//  LoginViewController.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 21/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.enterBtn.layer.cornerRadius = 15
        self.enterBtn.layer.borderWidth = 2.5
        self.enterBtn.layer.borderColor = UIColor.white.cgColor
        self.enterBtn.clipsToBounds = true
        self.enterBtn.layer.cornerRadius = 15
        self.email.layer.borderWidth = 2
        self.email.layer.cornerRadius = 15
        self.email.layer.borderColor = UIColor.white.cgColor
        self.password.layer.cornerRadius = 15
        self.password.layer.borderWidth = 2
        self.password.layer.borderColor = UIColor.white.cgColor
        
        // Do any additional setup after loading the view.
    }
    
}

