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
    @IBOutlet weak var street_number: UITextField!
    
    
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
        self.street_number.layer.borderWidth = 1
        self.street_number.layer.cornerRadius = 15
        self.street_number.layer.borderColor = UIColor.white.cgColor
       
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
    @IBAction func registerBtn(_ sender: Any) {
        
        if name.text == nil || (name.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire nome", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if surname.text == nil || (surname.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire cognome", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return

        }
        if email.text == nil || (email.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire mail", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if password.text == nil || (password.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if repeatPassword.text != password.text {
            let alert = UIAlertController(title: "Attenzione", message: "La password non corrisponde", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if repeatPassword.text!.isEmpty {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire conferma password", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if address.text == nil || (address.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire indirizzo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        if street_number.text == nil || (street_number.text?.isEmpty)! {
            let alert = UIAlertController(title: "Attenzione", message: "Inserire indirizzo", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let params:[String:String] = ["name": "\(name.text!)", "surname": "\(surname.text!)", "email" : "\(email.text!)", "password" : "\(password.text!)", "confirm_password" : "\(repeatPassword.text!)", "address" : "\(address.text!)", "street_number": "\(street_number.text!)"]
        
        let url = URL(string: "http://vigilesweb.test/api/register")!
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { response in
            // Dio qualcosa
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                guard response.error == nil
                    else {
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
                
                if response.response?.statusCode == 401 {
                    let alert = UIAlertController(title: "Attenzione", message: "NON FUNZIONA CAZZO", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else if response.response?.statusCode == 200 {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let postData = try jsonDecoder.decode(User.self, from: response.data!)
                        User.user = postData as AnyObject
                        print(postData, "BOH")
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
    }
