//
//  HistoricalViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import CoreLocation
import Kingfisher

class HistoricalViewController: UIViewController {
    @IBOutlet weak var todayTableView: UITableView!
    
    //    Si richiama Struct
    var reports = [Reports]()
    //    Variabile per imgView, la useremo per KingFisher
    var reportImgs = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTableView.separatorColor = UIColor(white: 1, alpha: 1)
        //        Riprende i dati in arrivo dalla funzione (vedi complete)
        ReportsModel().fetchEvents(complete: {
            (reports) in self.reports = reports
            //            Viene gestita l'esecuzione di più elementi di lavoro
            let queue = DispatchQueue.main
            //            Vengono eseguite più azioni "in parallelo"
            queue.async(execute: {
                self.todayTableView.delegate = self
                self.todayTableView.dataSource = self
                self.todayTableView?.reloadData()
            })
        })
    }
}

extension HistoricalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        Richiama il numero di elementi presenti nel db. Non fate il mio errore di mettere 1 o avrete una sola cella
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? HistoricalTableViewCell
        if self.reports.count > 0 {
            let report = self.reports[indexPath.row]
            cell?.emergencyTitle.text = report.title
            //            cell?.emergencyId.text = report.id
            cell?.emergencyAddress.text = report.address
            //            cell?.streetNumber.text = report.street_number
            cell?.emergencyDescription.text = report.description
            //            Converto url in stringa
            let imgUrl = URL(string: report.media!)
            //            kf è metodo diKingFisher
            cell?.codeImg.kf.setImage(with: imgUrl)
        }
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
    
    //    Gestisce la cancellazione di una cella
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            reports.remove(at: indexPath.row)
            todayTableView.reloadData()
        }
    }
}




