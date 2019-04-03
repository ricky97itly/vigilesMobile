//
//  HistoricalViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import CoreLocation

var testTitle = [""]
var testAddress = [""]

class HistoricalViewController: UIViewController {


    @IBOutlet weak var todayTableView: UITableView!
    @IBOutlet weak var yesterdayCollectionView: UICollectionView!
    var testImg = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    var testCode = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    
    var testId = ["000001", "000002", "000003"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        todayTableView.separatorColor = UIColor(white: 1, alpha: 1)
        // Do any additional setup after loading the view.
    }

}
    extension HistoricalViewController: UICollectionViewDataSource, UICollectionViewDelegate {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return testTitle.count
        }

        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as? CollectionViewCell
            cell?.title.text = testTitle[indexPath.row]
            cell?.codeImg.image = testImg[indexPath.row]
            cell?.image.image = testCode[indexPath.row]
            cell?.address.text = testAddress[indexPath.row]
            cell?.id.text = testId[indexPath.row]
            cell?.layer.cornerRadius = 15
            
            return cell!
        }

    }

extension HistoricalViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cella")
        cell.textLabel?.text = testTitle[indexPath.row]
        cell.detailTextLabel?.text = testAddress[indexPath.row]
        cell.layer.cornerRadius = 15
        cell.contentView.backgroundColor = UIColor(white: 1, alpha: 1)
        return (cell)
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




