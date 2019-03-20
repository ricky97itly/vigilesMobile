//
//  AddViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var emergencyDescription: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var mediaBtn: UIButton!
    @IBOutlet weak var tag: UITextField!
    @IBOutlet weak var chatBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBtn.layer.cornerRadius = 15
        self.addBtn.layer.borderWidth = 1
        self.addBtn.layer.borderColor = UIColor.white.cgColor
        self.addBtn.clipsToBounds = true
        self.mediaBtn.layer.cornerRadius = 15
        self.address.layer.cornerRadius = 15
        self.name.layer.cornerRadius = 15
        self.emergencyDescription.layer.cornerRadius = 15
        self.tag.layer.cornerRadius = 15
        self.address.delegate = self
        self.name.delegate = self
        self.emergencyDescription.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // Nasconde tastiera quando premo fuori
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // Nasconde tastiera quando premo invio
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        name.resignFirstResponder()
        address.resignFirstResponder()
        emergencyDescription.resignFirstResponder()
        return (true)
    }
    
    @IBAction func addEmergency() {
        print("Tap button")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
