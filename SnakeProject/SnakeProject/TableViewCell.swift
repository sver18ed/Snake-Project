//
//  TableViewCell.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    
    @IBOutlet weak var nameLabel2: UILabel!
    @IBOutlet weak var pointsLabel2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
