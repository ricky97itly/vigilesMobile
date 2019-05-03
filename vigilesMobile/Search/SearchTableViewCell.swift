//
//  SearchTableViewCell.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 04/04/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var codeImg: UIImageView!
    @IBOutlet weak var searchName: UILabel!
    @IBOutlet weak var searchAddress: UILabel!
    @IBOutlet weak var searchDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //space between cells
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 10
            frame.size.height -= 2 * 6
            super.frame = frame
        }
    }

}