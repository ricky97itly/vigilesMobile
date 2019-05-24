//
//  RegisterViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 20/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire
import ValidationComponents

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
        self.email.delegate = self
        UI()
        // Do any additional setup after loading the view.
    }
    
    func UI() {
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
    
// Per verificare che la mail abbia gli elementi che la compongono
   
    func validateFields() {
        let mail: String = email.text!
        let rule = EmailValidationPredicate()
        let isValidEmail = rule.evaluate(with: mail)
        
        if name.text == nil || (name.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire nome")
            return
        }
        if surname.text == nil || (surname.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire cognome")
            return
        }
        if email.text == nil || (email.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire mail")
            return
        }
        
        if password.text == nil || (password.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire password")
            return
        }
        if repeatPassword.text != password.text {
            Alert.showAlert(on: self, with: "Attenzione", message: "La password non corrisponde")
            return
        }
        if repeatPassword.text!.isEmpty {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire conferma password")
            return
        }
        if address.text == nil || (address.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire indirizzo")
            return
        }
        if street_number.text == nil || (street_number.text?.isEmpty)! {
            Alert.showAlert(on: self, with: "Attenzione", message: "Inserire numero civico")
            return
        }
        
        if isValidEmail {
            print("Mail valida")
        }
        else {
            Alert.showAlert(on: self, with: "Attenzione", message: "La mail non è valida")
            print("Mail non valida")
        }
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        validateFields()

        let params:[String:String] = ["name": "\(name.text!)", "surname": "\(surname.text!)", "email" : "\(email.text!)", "password" : "\(password.text!)", "confirm_password" : "\(repeatPassword.text!)", "address" : "\(address.text!)", "street_number": "\(street_number.text!)"]
        
        let url = URL(string: "http://vigilesweb.test/api/register")!
        Alamofire.request(url, method: .post, parameters: params).validate().responseJSON { response in
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)")
                
                guard response.error == nil
                    else {
                        Alert.showAlert(on: self, with: "Attenzione", message: "Non è possibile registrarsi, riprova più tardi")
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
                        let postData = try jsonDecoder.decode(MyUserData.self, from: response.data!)
//                        User.success = postData as AnyObject
//                        print(MyUserData.succes?.email as Any, "pro")
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
