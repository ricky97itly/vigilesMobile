//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate  {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var testImg = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    var testAddress = ["ciao", "prova", "claudia"]
    var testDescription = ["Nel mezzo del cammin di nostra claudia", "claudia ciao come stai??", "Madonna bonina san pancrazio cicciopuzzo ace + fabri no comment..."]
    var testTitle = ["mena", "porcatroia", "brutta zoccola"]

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.self.delegate = self
        self.searchBar.layer.cornerRadius = 20
        self.searchBar.clipsToBounds = true
       
        // Do any additional setup after loading the view.
    }
    
    // hide keyboard when I press outise
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return (true)
    }
    
//    @IBAction func changeView(sender: UISwipeGestureRecognizer) {
//        if sender.direction == UISwipeGestureRecognizer.Direction.left {
//            self.tabBarController?.selectedIndex = 0
//        }
//        else if sender.direction == UISwipeGestureRecognizer.Direction.right {
//            self.tabBarController?.selectedIndex = 1
//        }
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testTitle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as? DataCollectionViewCell
        cell?.emergencyTitle.text = testTitle[indexPath.row]
        cell?.codeImg.image = testImg[indexPath.row]
        cell?.emergencyAddress.text = testAddress[indexPath.row]
        cell?.emergencyDescription.text = testDescription[indexPath.row]
        return cell!
    }
}
