//
//  HighScoreManager.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-12-06.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import Foundation

let theUrl = "https://api.myjson.com/bins/fmxjk"

class HighScoreManager{
    
    
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
                    highScoreData = highScoreData.sorted(by: { $0.points > $1.points })
                } catch{
                    print("Error")
                }
                completion(highScoreData)
            }
        }
        task.resume()
    }
}


