//
//  ForgottenPassword.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import UIKit
import Parse

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
        email.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        email.resignFirstResponder()
        return (true)
    }
    
    @IBAction func sendMail(_ sender: Any) {
        let mail = email.text
        if mail!.isEmpty {
            let userMessage:String = "Per favore, inserisci il tuo indirizzo mail"
            showMessage(userMessage: userMessage)
            return
        }
        PFUser.requestPasswordResetForEmail(inBackground: mail!, block: {(success:Bool, error:NSError?) -> Void in
            
            if error != nil {
                // messaggio errore
                let userMessage:String = error!.localizedDescription
                self.showMessage(userMessage: userMessage)
            }
            else {
                // messaggio successo
                let userMessage:String = "Una mail è stata mandata a \(mail)"
                self.showMessage(userMessage: userMessage)
            }
            
            } as! PFBooleanResultBlock)
        
    }
    func showMessage(userMessage:String) {
        Alert.showAlert(on: self, with: "Attenzione", message: userMessage)
    }
}
