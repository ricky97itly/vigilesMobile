//
//  AddViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var emergencyDescription: UITextField!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAddress: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var addBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addBtn.layer.cornerRadius = 15
        self.addBtn.layer.borderWidth = 1
//        self.addBtn.layer.borderColor = UIColor.clear.cgColor
        self.addBtn.clipsToBounds = true
        
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addEmergency() {
        labelName.text = "Ciao Ale"
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
