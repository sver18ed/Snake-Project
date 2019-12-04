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
    var bestScore: Int = UserDefaults.standard.integer(forKey: "bestScore")
    
    func setBestScore() {
        if currentScore > bestScore {
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
            bestScore = currentScore
        }
    }
    
    func resetCurrentScore() {
        currentScore = 0
    }
}
