//
//  ViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 06/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("ciao come stai?")
        print("hello, S.ara")
        print("Claudia bella")
        print("ciao")
        print("hola")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
   


}

