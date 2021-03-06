//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import Kingfisher
import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    var reports = [Reports]()
    var reportImgs = [UIImageView]()
    var selectedReports = [Reports]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.self.delegate = self
        self.searchBar.layer.cornerRadius = 20
        self.searchBar.clipsToBounds = true
        selectedReports = reports
        
        ReportsModel().funcRequest(complete: {
            (reports) in self.reports = reports
            //            Viene gestita l'esecuzione di più elementi di lavoro
            let queue = DispatchQueue.main
            queue.async(execute: {
                self.searchTableView.delegate = self
                self.searchTableView.dataSource = self
                self.searchTableView?.reloadData()
            })
        })
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
    
    @IBAction func infoBtn(_ sender: Any) {
        Alert.showAlert(on: self, with: "Ricerca", message: "Qui potrai effettuare le ricerce scrivendo l'indirizzo da te desiderato.")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("PROVA1")
        guard !searchText.isEmpty
            else {
                print("PROVA2")
                searchTableView.reloadData()
                return
        }
        print("PROVA3")
        
        selectedReports = reports.filter({
            reports -> Bool in (reports.address?.lowercased().contains(searchText.lowercased()))!
        })
        print(reports)
        print(selectedReports)
        print("PROVA4")
        
        searchTableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        Richiama il numero di elementi presenti nel db (imp! -> con 1, si avrà una sola cella)
        return selectedReports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? SearchTableViewCell
        if self.selectedReports.count > 0 {
            let report = self.selectedReports[indexPath.row]
            cell?.searchName.text = report.title
            //            cell?.emergencyId.text = report.id
            cell?.searchAddress.text = report.address
            //            cell?.streetNumber.text = report.street_number
            
            switch report.code_id {
            case 2:
                let green = #imageLiteral(resourceName: "code-green")
                cell?.codeImg.image = green
            case 3:
                let yellow = #imageLiteral(resourceName: "code")
                cell?.codeImg.image = yellow
            case 4:
                let red = #imageLiteral(resourceName: "code-red")
                cell?.codeImg.image = red
            default:
                break
            }
            
            cell?.searchDescription.text = report.description
            
            //            Converto url in stringa
            let imgUrl = URL(string: report.media ?? "valore" )
            //            kf è metodo di KingFisher
            cell?.emergencyImg.kf.setImage(with: imgUrl)
            cell?.codeImg.layer.cornerRadius = (cell?.codeImg.frame.width)! / 2.1
            cell?.codeImg.layer.masksToBounds = true
        }
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
}
