//
//  ChatTableViewCell.swift
//  vigilesMobile
//
//  Created by Claudia Lolli on 29/04/2019.
//  Copyright © 2019 Riccardo Mores. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {
    @IBOutlet weak var chatTitle: UILabel!
    @IBOutlet weak var chatNumber: UILabel!
    @IBOutlet weak var chatImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

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
