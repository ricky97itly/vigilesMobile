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
        self.email.layer.borderWidth = 2
        self.email.layer.cornerRadius = 15
        self.email.layer.borderColor = UIColor.white.cgColor
        self.password.layer.cornerRadius = 15
        self.password.layer.borderWidth = 2
        self.password.layer.borderColor = UIColor.white.cgColor
        // Do any additional setup after loading the view.
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
    

    }
    

//    @IBAction func EnterBtn(_ sender: Any) {
//        let email =_email.text
//        let password =_password.text
//
//       if(email == "" || password == "") {
//            return
//    }
//
//        DoLogin(email!, password!)
//    }
//
//    func DoLogin(_ email:String, _ psw:String) {
//       let url = URL (string: "")
//       let session = URLSession.shared
//   
//       let request = NSMutableURLRequest(url: url)
//
//    }
//    
//}


