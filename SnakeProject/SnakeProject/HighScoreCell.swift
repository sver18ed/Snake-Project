//
//  HighScoreCell.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {

 
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
