//
//  HighScoreManager.swift
//  SnakeProject
//
//  Created by Håkan Thorleifsson on 2019-12-06.
//  Copyright © 2019 Erik Sveningsson. All rights reserved.
//

import Foundation


class HighScoreManager{

    
    static func fetchHighScore(completion: @escaping ([HighScoreData])->()) {
        guard let url = URL(string: "https://api.myjson.com/bins/q4e78") else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (responseData, response, responseError) in
            
            var highScoreData = DataHandler.instance.highScoreData
               
            if let data = responseData{
                
                do {
                    let decoder = JSONDecoder()
                    let downloadedHighscore = try decoder.decode(HighScoreDict.self, from: data)
                    highScoreData.append(contentsOf: downloadedHighscore.highScore)
                    //DataHandler.instance.highScoreData.append(contentsOf: downloadedHighscore.highScore)

                    
                } catch{
                    print("Error")
                }
                completion(highScoreData)
                
            }
            
            }
        task.resume()
        }
  
 
}


