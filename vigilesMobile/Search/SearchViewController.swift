//
//  SearchViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var reports = [Reports]()
    //    var originalReports = [Reports]()
    var selectedReports = [Reports]()
    var reportImgs = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.self.delegate = self
        self.searchBar.layer.cornerRadius = 20
        self.searchBar.clipsToBounds = true
        selectedReports = reports
        ReportsModel().fetchEvents(complete: {
            (reports) in self.reports = reports
            //            Viene gestita l'esecuzione di più elementi di lavoro
            let queue = DispatchQueue.main
            //            Vengono eseguite più azioni "in parallelo"
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
        print("mortacci tua")
        guard !searchText.isEmpty
            else {
                print("mena")
                searchTableView.reloadData()
                return
        }
        print("taralli")
        selectedReports = reports.filter({
            reports -> Bool in (reports.address?.lowercased().contains(searchText.lowercased()))!
        })
        print(reports)
        print(selectedReports)
        print("tvb")
        searchTableView.reloadData()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        Richiama il numero di elementi presenti nel db. Non fate il mio errore di mettere 1 o avrete una sola cella
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
            cell?.searchDescription.text = report.description
            //            Converto url in stringa
            let imgUrl = URL(string: report.media!)
            //            kf è metodo di KingFisher
            cell?.codeImg.kf.setImage(with: imgUrl)
        }
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
}




