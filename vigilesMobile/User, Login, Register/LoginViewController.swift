//
//  LoginViewController.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 21/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import Alamofire
import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var enterBtn: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var registerBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UI()
    } 
    
    func UI() {
        self.email.layer.borderColor = UIColor.white.cgColor
        self.email.layer.borderWidth = 2
        self.email.layer.cornerRadius = 15
        self.enterBtn.clipsToBounds = true
        self.enterBtn.layer.borderColor = UIColor.white.cgColor
        self.enterBtn.layer.borderWidth = 2.5
        self.password.layer.borderColor = UIColor.white.cgColor
        self.password.layer.borderWidth = 2
        self.password.layer.cornerRadius = 15
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
        
        let params:[String:String] = ["email" : "\(email.text!)", "password" : "\(password.text!)"]
        let url = URL(string: "http://vigilesweb.test/api/login")!
        
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { response in
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                guard response.error == nil
                    else {
                        Alert.showAlert(on: self, with: "Attenzione", message: "Username o password non sono corretti")
                        print(response.error!)
                        return
                }
                guard (response.value as? [String:Any]) != nil
                    else {
                        if let error = response.error {
                            print("ERRORE: \(error)")
                        }
                        return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    var postData = try jsonDecoder.decode(MyUserData.self, from: response.data!)
                    print(postData.success.name as Any)
//                  Verrà richiamato nel profilo
                    MyUserData.user = postData
                    let storyBoard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Enter")
                    self.present(nextViewController, animated:true, completion:nil)
                }
                catch {
                    print("JSONSerialization error:", error)
                }
            }
        }
    }
}
