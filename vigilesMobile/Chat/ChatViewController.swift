//
//  ChatViewController.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import UIKit
import Alamofire

var testChat = [String]()


class ChatViewController: UIViewController {    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var chatTV: UITableView!
    var chatImg = [UIImage(named: "code-yellow"), UIImage(named: "code-green"), UIImage(named: "code-red")]
    var chatTitle = ["Incidente", "Schianto", "Apple Chiusa"]
    var chatNumber = ["Segnalazione 0001", "Segnalazione 0002", "Segnalazione 0003"]
    var reports = [Reports]()
    var selectedReports = [Reports]()
    var reportImgs = [UIImageView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ReportsModel().funcRequest(complete: {
            (reports) in self.reports = reports
            //            Viene gestita l'esecuzione di più elementi di lavoro
            let queue = DispatchQueue.main
            //            Vengono eseguite più azioni "in parallelo"
            queue.async(execute: {
                self.chatTV.delegate = self
                self.chatTV.dataSource = self
                self.chatTV?.reloadData()
            })
        })
        // Do any additional setup after loading the view.
    }
}

//extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return chatTitle.count
//    }
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = chatCV.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as? ChatCollectionViewCell
//        cell?.chatTitle.text = chatTitle[indexPath.row]
//        cell?.chatImg.image = chatImg[indexPath.row]
//        cell?.chatNumber.text = chatNumber[indexPath.row]
//        cell?.layer.cornerRadius = 15
//        return cell!
//    }
//}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? ChatTableViewCell
        if self.reports.count > 0 {
            let report = self.reports[indexPath.row]
            cell?.chatTitle.text = report.title
            //            Converto url in stringa
            let imgUrl = URL(string: report.media!)
            //            kf è metodo diKingFisher
            cell?.chatImg.kf.setImage(with: imgUrl)
        }
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
    
    
}



