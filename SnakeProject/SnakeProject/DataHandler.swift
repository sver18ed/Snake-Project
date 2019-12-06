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
    
    var highScoreData: [HighScoreData] = UserDefaults.standard.array(forKey: "HighScoreKey") as? [HighScoreData] ?? []
    
    func setBestScore() {
        if currentScore > bestScore {
            UserDefaults.standard.set(currentScore, forKey: "bestScore")
            bestScore = currentScore
        }
    }
    
    func resetCurrentScore() {
        currentScore = 0
    }
    
    func highScoreData(highScoreData: [HighScoreData]){
        self.highScoreData = highScoreData
    }
    
    func sendNewHighScoreDict(){
        guard let url = URL(string: "https://api.myjson.com/bins/q4e78") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(HighScoreDict.init(highScore: DataHandler.instance.highScoreData)) else {return}
        
        request.httpBody = httpBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        }.resume()
    }
    
    
}
