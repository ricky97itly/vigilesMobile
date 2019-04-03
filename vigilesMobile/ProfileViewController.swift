//
//  ProfileViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var numberOfSegnalations: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        profilePic.layer.borderWidth = 1
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height/2.1
        profilePic.clipsToBounds = true

        // Do any additional setup after loading the view.
    }
    @IBAction func logoutBtn(_ sender: UIButton) {
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
