//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire

var titleSearch = ["boh"]
var addressSearch = ["Prova"]
var descriptionSearch = ["funziona coglione della merda"]

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!

    var testImg = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    var testAddress = ["ciao", "prova", "claudia"]
    var testDescription = ["Nel mezzo del cammin di nostra claudia", "claudia ciao come stai??", "Madonna bonina san pancrazio cicciopuzzo ace + fabri no comment..."]
    var testTitle = ["mena", "porcatroia", "brutta zoccola"]
    var emergencyArray = [Emergency]()
    var selectedEmergencyArray = [Emergency]()


    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.self.delegate = self
        self.searchBar.layer.cornerRadius = 20
        self.searchBar.clipsToBounds = true
        setUpEmergency()
       
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
    
//    Riempio array emergenze
    func setUpEmergency() {
        emergencyArray.append(Emergency(title: "Albero caduto", address: "Via Papa Roma, 32", description: "Un albero è caduto sopra una Tesla", code: SearchViewController.Emergency.CodeType(rawValue: "Verde")!))
        emergencyArray.append(Emergency(title: "Incendio", address: "Via Scheiwiller, 1", description: "Incendio dovuto ad un cassonetto", code: SearchViewController.Emergency.CodeType(rawValue: "Giallo")!))
        emergencyArray.append(Emergency(title: "Ascensore bloccato", address: "Via Amatore Sciesa, 4", description: "Sono rimasto bloccato nell'ascensore dello ied", code: SearchViewController.Emergency.CodeType(rawValue: "Rosso")!))
        
        selectedEmergencyArray = emergencyArray
    }
}

//extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return testTitle.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as? DataCollectionViewCell
//        cell?.emergencyTitle.text = testTitle[indexPath.row]
//        cell?.codeImg.image = testImg[indexPath.row]
//        cell?.emergencyAddress.text = testAddress[indexPath.row]
//        cell?.emergencyDescription.text = testDescription[indexPath.row]
//        cell?.layer.cornerRadius = 15
//        return cell!
//    }
//}

extension SearchViewController: UITabBarDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty
            else {
                selectedEmergencyArray = emergencyArray
                searchTableView.reloadData()
                return
        }
        selectedEmergencyArray = emergencyArray.filter({
            emergency -> Bool in emergency.address.lowercased().contains(searchText.lowercased())
        })
        
        searchTableView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        switch selectedScope {
//        case 0:
//            selectedEmergencyArray = emergencyArray
//        case 1:
//            selectedEmergencyArray = selectedEmergencyArray.filter({emergency -> Bool in emergency.code == CodeType.green})
//        case 2:
//            selectedEmergencyArray = selectedEmergencyArray.filter({emergency -> Bool in emergency.code == CodeType.yellow})
//        case 3:
//            selectedEmergencyArray = selectedEmergencyArray.filter({emergency -> Bool in emergency.code == CodeType.red})
//        default:
//            break
//        }
//        searchTableView.reloadData()
//    }
    
    class Emergency {
        var title: String
        var address: String
        var description: String
        var code: CodeType
        
//        Definisco i valori da dare all'oggetto

        init(title: String, address: String, description: String, code: CodeType) {
            self.title = title
            self.address = address
            self.description = description
            self.code = code
        }
        
//        Raggruppamento oggetti
        
        enum CodeType: String {
            case green = "Verde"
            case yellow = "Giallo"
            case red = "Rosso"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedEmergencyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cella")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? SearchTableViewCell
        cell?.searchName.text = selectedEmergencyArray[indexPath.row].title
        cell?.searchAddress.text = selectedEmergencyArray[indexPath.row].address
        cell?.searchDescription.text = selectedEmergencyArray[indexPath.row].description
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            testTitle.remove(at: indexPath.row)
            searchTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchTableView.reloadData()
    }
}



