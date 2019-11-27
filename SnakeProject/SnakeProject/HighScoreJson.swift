//
//  HighScoreJson.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScores: Codable{
    let dict: [HighScoreJson]
    
    init(dict:[HighScoreJson]){
        self.dict = dict
    }
}

class HighScoreJson: Codable {
    let name: String
    let points: String
    
    init(name: String, points: String){
        self.name = name
        self.points = points
    }

}
