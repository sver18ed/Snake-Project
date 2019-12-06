//
//  HighScoreDict.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-12-06.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import Foundation

class HighScoreDict: Codable {
    let highScore: [HighScoreData]
    
    init(highScore: [HighScoreData]) {
        self.highScore = highScore
    }
}
