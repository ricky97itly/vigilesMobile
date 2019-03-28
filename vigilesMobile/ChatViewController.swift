//
//  ChatViewController.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 28/03/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {    
    @IBOutlet weak var chatCV: UICollectionView!
    @IBOutlet weak var backBtn: UIButton!
    var chatImg = [UIImage(named: "code"), UIImage(named: "code"), UIImage(named: "code")]
    var chatTitle = ["Incidente", "Schianto", "Apple Chiusa"]
    var chatNumber = ["Segnalazione 0001", "Segnalazione 0002", "Segnalazione 0003"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

extension ChatViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatTitle.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = chatCV.dequeueReusableCell(withReuseIdentifier: "cella", for: indexPath) as? ChatCollectionViewCell
        cell?.chatTitle.text = chatTitle[indexPath.row]
        cell?.chatImg.image = chatImg[indexPath.row]
        cell?.chatNumber.text = chatNumber[indexPath.row]
        return cell!
    }
    
  
}
