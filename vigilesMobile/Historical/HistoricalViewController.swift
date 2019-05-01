//
//  HistoricalViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON
import AlamofireImage
// Array globale, si può richiamare ovunque :-) 

var testTitle = [String]()
var testAddress = [String]()

class HistoricalViewController: UIViewController {
    @IBOutlet weak var todayTableView: UITableView!

//    Creiamo un dizionario per le segnalazioni
    var reports : [[String: Any]] = [[String: Any]]()
//    Costante per url segnalazioni, si crea così se si deve modificare basta farlo da qua
    let url = URL(string: "http://vigilesweb.test/api/reports")!

    override func viewDidLoad() {
        super.viewDidLoad()
        todayTableView.separatorColor = UIColor(white: 1, alpha: 1)
        
            Alamofire.request(url).responseJSON {
                response in
//                Se il valore ricevuto è di tipo stringa passa all'if successivo
                if let responseValue = response.result.value as! [String: Any]? {
//                   Se riceve "data" con tutto il resto di tipo stringa esegue quello che c'è al suo interno
                    if let responseReports = responseValue["data"] as! [[String: Any]]? {
                        self.reports = responseReports
//                        Ricarica elementi dentro TB e mostra solo quelli presenti
                        self.todayTableView?.reloadData()
                        print(response.value!)
                    }
                }
                
            }
        // Do any additional setup after loading the view.
    }
    
    

}

extension HistoricalViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cella")
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? HistoricalTableViewCell
        if self.reports.count > 0 {
            let eachReport = self.reports[indexPath.row]
            cell?.emergencyTitle?.text = (eachReport["title"] as? String)
            cell?.emergencyId?.text = (eachReport["id"] as? String)
            cell?.emergencyAddress?.text = (eachReport["address"] as? String)
            cell?.streetNumber?.text = (eachReport["street_number"] as? String)
            cell?.emergencyDescription?.text = (eachReport["description"] as? String)


         }
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            testTitle.remove(at: indexPath.row)
            todayTableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        todayTableView.reloadData()
    }
}




