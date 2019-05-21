//
//  ProfileViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ProfileViewController: UIViewController {
    
    
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var surname: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var mail: UILabel!
    @IBOutlet weak var numberOfSegnalations: UILabel!
    @IBOutlet weak var street_number: UILabel!
    @IBOutlet weak var logoutBtn: UIButton!
    let url = URL(string: "http://vigilesweb.test/api/login")!
    var profileImg = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.logoutBtn.layer.cornerRadius = 15
        self.logoutBtn.layer.borderWidth = 2.5
        self.logoutBtn.layer.borderColor = UIColor.white.cgColor
        self.logoutBtn.clipsToBounds = true
        profilePic.layer.masksToBounds = false
        profilePic.layer.borderColor = UIColor.black.cgColor
        profilePic.layer.cornerRadius = profilePic.frame.height/2.1
        profilePic.clipsToBounds = true
        // Richiamo dati dal login
        name.text = "\(MyUserData.user!.success.name!)"
        surname.text = "\(MyUserData.user!.success.surname!)"
        mail.text = "\(MyUserData.user!.success.email!)"
        address.text = "\(MyUserData.user!.success.address!)"
        street_number.text = "\(MyUserData.user!.success.street_number!)"
    }
    
    @IBAction func logoutBtn(_ sender: UIButton) {
        //        performSegue(withIdentifier: "Main.storyboard", sender: self)
    }
}

