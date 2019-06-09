//
//  HistoricalTableViewCell.swift
//  vigilesMobile
//
//  Created by Riccardo Mores on 03/04/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class HistoricalTableViewCell: UITableViewCell {
    @IBOutlet weak var codeImg: UIImageView!
    @IBOutlet weak var emergencyImg: UIImageView!
    @IBOutlet weak var emergencyTitle: UILabel!
    @IBOutlet weak var emergencyAddress: UILabel!
//    @IBOutlet weak var emergencyId: UILabel!
    @IBOutlet weak var streetNumber: UILabel!
    @IBOutlet weak var emergencyDescription: UILabel!
    
    //    Spazio tra le celle
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.size.height -= 12
            super.frame = frame
        }
    }
}
