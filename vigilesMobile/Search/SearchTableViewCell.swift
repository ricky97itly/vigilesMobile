//
//  SearchTableViewCell.swift
//  vigilesMobile
//
//  Created by vigiles_admin on 08/03/2019.
//  Copyright © 2019 Vigiles. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var codeImg: UIImageView!
    @IBOutlet weak var emergencyImg: UIImageView!
    @IBOutlet weak var searchAddress: UILabel!
    @IBOutlet weak var searchDescription: UILabel!
    @IBOutlet weak var searchName: UILabel!
    
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
