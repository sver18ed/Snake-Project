//
//  HighScoreJson.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-11-27.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import UIKit

class HighScores: Codable{
    let highScore: [HighScoreData]
    
    init(highScore:[HighScoreData]){
        self.highScore = highScore
    }
}

class HighScoreData: Codable {
    let name: String
    let points: Int
    
    init(name: String, points: Int){
        self.name = name
        self.points = points
    }
}
