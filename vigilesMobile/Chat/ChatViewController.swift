//
//  ChatViewController.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 28/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit
import Alamofire

var testChat = [String]()

class ChatViewController: UIViewController {    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var chatCV: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var chatTV: UITableView!
    var chatImg = [UIImage(named: "code"), UIImage(named: "code"), UIImage(named: "code")]
    var chatTitle = ["Incidente", "Schianto", "Apple Chiusa"]
    var chatNumber = ["Segnalazione 0001", "Segnalazione 0002", "Segnalazione 0003"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        return chatTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cella", for: indexPath) as? ChatTableViewCell
        cell?.chatTitle.text = chatTitle[indexPath.row]
        cell?.chatImg.image = chatImg[indexPath.row]
        cell?.layer.cornerRadius = 15
        return (cell!)
    }
    
    
}



