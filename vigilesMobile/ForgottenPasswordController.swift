//
//  ForgottenPassword.swift
//  vigilesMobile
//
//  Created by Valeria Spanò on 16/04/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class ForgottenPasswordController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var sendBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
    }
    
    func UI() {
        self.sendBtn.layer.borderWidth = 2.5
        self.sendBtn.layer.borderColor = UIColor.white.cgColor
        self.sendBtn.layer.cornerRadius = 15
        self.sendBtn.clipsToBounds = true
        self.email.layer.borderWidth = 2
        self.email.layer.borderColor = UIColor.white.cgColor
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        return (true)
    }
}
