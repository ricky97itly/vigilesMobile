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
    
    // hide keyboard when I press outside 
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    // hide keyboard when I press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBar.resignFirstResponder()
        return (true)
    }
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
        cell?.layer.cornerRadius = 15
        return cell!
    }
}
