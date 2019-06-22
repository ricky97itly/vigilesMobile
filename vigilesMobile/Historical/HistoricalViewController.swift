//
//  HistoricalViewController.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import CoreLocation
import Kingfisher
import UIKit

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
        modelInvocation()
    }
    
    func modelInvocation() {
        ReportsModel().funcRequest(complete: {
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
            cell?.emergencyAddress.text = report.address! + " \(report.street_number!)"
            
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
            
//            cell?.streetNumber.text = "\(report.street_number)"
            cell?.emergencyDescription.text = report.description
            //            Converto url in stringa
            let imgUrl = URL(string: report.media!)
            //            kf è metodo diKingFisher
            cell?.emergencyImg.kf.setImage(with: imgUrl)
        }
        cell?.layer.cornerRadius = 15
        return (cell!)
    } // Fine funzione tableView
    
    
    //    Gestisce la cancellazione di una cella (non serve ma lo tengo per il futuro)
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == UITableViewCell.EditingStyle.delete {
//            reports.remove(at: indexPath.row)
//            todayTableView.reloadData()
//        }
//    }
}




