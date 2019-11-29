//
//  DataHandler.swift
//  SnakeProject
//
//  Created by Andreas Malmström on 2019-11-29.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import Foundation

class DataHandler {
    
    static let instance = DataHandler()
    var currentScore: Int = 0
    var bestScore: Int = 0
    
    func setBestScore() {
        if currentScore > bestScore{
            bestScore = currentScore
        }
    }
    func resetCurrentScore() {
        currentScore = 0
    }
}
