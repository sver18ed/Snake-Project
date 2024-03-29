//
//  HighScoreJson.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScoreData: Codable {
    
    let name: String
    let points: Int
    
    init(name: String, points: Int){
        self.name = name
        self.points = points
    }
}
