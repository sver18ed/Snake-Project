//
//  HighScoreManager.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-12-06.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import Foundation


var userInput = false
let theUrl = "https://api.myjson.com/bins/fmxjk"

class HighScoreManager{
    
    static let instance = HighScoreManager()
    
    //MARK: - fetchHighScore
    
    static func fetchHighScore(completion: @escaping ([HighScoreData])->()) {
        guard let url = URL(string: theUrl ) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (responseData, response, responseError) in
            
            var highScoreData = [HighScoreData]()
               
            if let data = responseData{
                
                do {
                    let decoder = JSONDecoder()
                    let downloadedHighscore = try decoder.decode(HighScoreDict.self, from: data)
                    highScoreData.append(contentsOf: downloadedHighscore.highScore)
                    if userInput{
                        highScoreData.append(contentsOf: DataHandler.instance.highScoreData)
                        DataHandler.instance.highScoreData.removeAll()
                        DataHandler.instance.highScoreData.append(contentsOf: highScoreData)
                        HighScoreManager.instance.updateHighScore()
                        userInput = false
                    }
                    DataHandler.instance.highScoreData.removeAll()
                    highScoreData = highScoreData.sorted(by: { $0.points > $1.points })
                } catch{
                    print("Error")
                }
                completion(highScoreData)
            }
        }
        task.resume()
    }
    
    //MARK: - updateHighScore
    
    func updateHighScore(){
        guard let url = URL(string: theUrl) else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONEncoder().encode(HighScoreDict.init(highScore: DataHandler.instance.highScoreData)) else {
            return
        }
        
        request.httpBody = httpBody

        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            
        }
        task.resume()
    }
}


