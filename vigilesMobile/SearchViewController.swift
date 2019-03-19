//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate  {

    @IBOutlet weak var search: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        search.self.delegate = self

        // Do any additional setup after loading the view.
    }
    
    // hide keyboard when I press outise
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        search.resignFirstResponder()
        return (true)
    }
    
    @IBAction func changeView(sender: UISwipeGestureRecognizer) {
        if sender.direction == UISwipeGestureRecognizer.Direction.left {
            self.tabBarController?.selectedIndex = 0
        }
        else if sender.direction == UISwipeGestureRecognizer.Direction.right {
            self.tabBarController?.selectedIndex = 1
        }
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
