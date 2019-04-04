//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

var titleSearch = ["boh"]
var addressSearch = ["Prova"]
var descriptionSearch = ["funziona coglione della merda"]

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (titleSearch.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.codeTitle.text = titleSearch[indexPath.row]
        cell.codeAddress.text = addressSearch[indexPath.row]
        cell.codeDescription.text = descriptionSearch[indexPath.row]
        cell.layer.cornerRadius = 15
        
        return(cell)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
            titleSearch.remove(at: indexPath.row)
            tableView.reloadData()
        }
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


