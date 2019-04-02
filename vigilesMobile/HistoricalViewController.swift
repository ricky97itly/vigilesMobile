//
//  HistoricalViewController.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 09/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import CoreLocation

class HistoricalViewController: UIViewController {
    @IBOutlet weak var chatBtn: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var testTitle = ["ciao", "boh", "mena"]
    var testImg = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    var testCode = [UIImage(named: "infantes"), UIImage(named: "tony"), UIImage(named: "solcia")]
    var testAddress = ["ciao", "prova", "claudia"]
    var testId = ["000001", "000002", "000003"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    
    */
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


